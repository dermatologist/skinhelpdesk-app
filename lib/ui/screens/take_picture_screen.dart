import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skinhelpdesk_app/models/message.dart';
import 'package:skinhelpdesk_app/models/submission.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:skinhelpdesk_app/service/skinhelpdesk-rapid-api.dart';
import 'package:skinhelpdesk_app/ui/widgets/display_api_data.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  bool? _initialized;

  late Future<Message> message;
  Submission submission =
      new Submission(Payload: '', Service: '', ValueCode: 35);

  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    // Next, initialize the controller. This returns a Future.
    // To display the current output from the Camera,
    // create a CameraController.

    this.cameraInitializeAndPreview().then((value) {
      _initialized = true;
    });

    //submission.Service = 'charm-go-test';
    submission.ValueCode = 1;
  }

  Future<Message> createPost() async {
    APIService apiService = APIService();
    final response =  await apiService.post(endpoint:'/shdtone', query: jsonEncode(submission));
    return Message.fromJson(response);
  }

  Future<File> _cropImage(File imageFile) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );
    if (croppedFile != null) {
      return croppedFile;
    } else {
      return imageFile;
    }
  }

  Future<void> cameraInitializeAndPreview() async {
    // Obtain a list of the available cameras on the device.
    this.cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = this.cameras?.first;

    this._controller = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera!,
      // Define the resolution to use.
      ResolutionPreset.medium,
      enableAudio: false,
    );
    this._initializeControllerFuture = this._controller.initialize();
    return this._initializeControllerFuture;
  }

  /// Returns a suitable camera icon for [direction].
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (this._controller.value.isRecordingVideo) {
      await this._controller.dispose();
    }
    this._controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    // If the this._controller is updated then update the UI.
    this._controller.addListener(() {
      if (mounted) setState(() {});
      if (this._controller.value.hasError) {
        //showInSnackBar('Camera error ${this._controller.value.errorDescription}');
      }
    });

    try {
      // await this._controller.initialize();
      this._initializeControllerFuture = this._controller.initialize();
    } on CameraException catch (e) {
      //_showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (this.cameras!.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras!) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: this._controller.description,
              value: cameraDescription,
              onChanged: null,
            ),
          ),
        );
      }
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: CameraPreview(this._controller),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: toggles),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              _initialized!) {
            // If the Future is complete, display the preview.
            //return CameraPreview(_controller);
            return _cameraTogglesRowWidget();
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;


            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            File cropped = await _cropImage(File(image.path));

            // Read file as string and set payload
            //submission.Payload = await File(path).readAsString();
            // https://stackoverflow.com/questions/50036393/how-to-convert-an-image-to-base64-image-in-flutter
            List<int> imageBytes = await cropped.readAsBytes();
            String base64Image = base64Encode(imageBytes);
            submission.Payload = base64Image;
            message = createPost();

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: image.path, message: message),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final Future<Message> message;
  const DisplayPictureScreen({Key? key, required this.imagePath, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.

      body: DisplayApiData(
        imagePath: imagePath,
        message: message,
      ),
    );
  }
}
