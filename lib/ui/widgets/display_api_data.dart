import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:skinhelpdesk_app/models/message.dart';

class DisplayApiData extends StatelessWidget {
  final Future<Message> message;
  final String imagePath;

  const DisplayApiData({
    Key? key,
    required this.imagePath,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Looks!'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new FileImage(new File(imagePath)),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<Message>(
          future: message,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> results = snapshot.data!.Result.cast<dynamic>();
              return ListView.builder(
                itemCount: snapshot.data!.Result.length,
                itemBuilder: (context, index) {
                  if (results[index]["Max"] == 0) {
                    return Card(
                      //                           <-- Card widget
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/face.png'),
                        ),
                        title: Text(results[index]["Title"]),
                        subtitle: Text(results[index]["Detail"]),
                      ),
                    );
                  } else {
                    // https://pub.dev/packages/percent_indicator
                    return Card(
                      //                           <-- Card widget
                      child: CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 10.0,
                        animation: true,
                        percent: (results[index]["ValueCompute"] -
                                results[index]["Min"]) /
                            (results[index]["Max"] - results[index]["Min"]),
                        center: new Text(
                          results[index]["Detail"],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        footer: new Text(
                          results[index]["Title"],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.purple,
                      ),
                    );
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}