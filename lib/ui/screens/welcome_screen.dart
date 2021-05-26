import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Icon(
              Icons.phone_iphone,
              color: Color.fromRGBO(212, 20, 15, 1.0),
              size: 125.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
            child: Text(
              "Mirror Mirror!",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(212, 20, 15, 1.0),
                decoration: TextDecoration.none,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "How do I look today.",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "By Clicking Camera button below, you agree to "
                  "the terms of use and privacy policy above.",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 12.0,
                fontWeight: FontWeight.w200,
                fontFamily: "Ariel",
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 60.0),
            child: ElevatedButton(
              style: style,
              child: const Text('Camera'),
              onPressed: () {
                Navigator.of(context).pushNamed("/camera");
              },
            ),
          ),
        ],
      ),
    );
  }
}