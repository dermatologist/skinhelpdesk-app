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
