import 'package:flutter/material.dart';
import 'package:skinhelpdesk_app/ui/screens/take_picture_screen.dart';
import 'package:skinhelpdesk_app/ui/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkinHelpDesk Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      routes: <String, WidgetBuilder>{
        '/welcome': (BuildContext context) => new WelcomeScreen(),
        '/camera': (BuildContext context) => new TakePictureScreen(),
        },
      home: new WelcomeScreen(),
    );
  }
}
