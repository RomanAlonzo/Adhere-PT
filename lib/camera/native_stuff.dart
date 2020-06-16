import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class NativeStuff extends StatefulWidget {
  @override
  NativeStuffState createState() {
    return NativeStuffState();
  }
}

class NativeStuffState extends State<NativeStuff> {
  static const platformMethodChannel =
  const MethodChannel('heartbeat.fritz.ai/native');
  String nativeMessage = '';


  Future<Null> _launchCamera() async {
    String _message;
    try {
      final String result =
      await platformMethodChannel.invokeMethod('takePhoto');
      _message = result;
    } on PlatformException catch (e) {
      _message = "Can't do native stuff ${e.message}.";
    }
    setState(() {
      nativeMessage = _message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: Center(
              child: FlatButton.icon(
                icon: Icon(
                  Icons.photo_camera,
                  size: 100,
                ),
                label: Text(''),
                textColor: Colors.white,
                onPressed: _launchCamera,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: Center(
              child: Text(
                nativeMessage,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 23.0),
              ),
            ),
          )
        ],
      ),
    );
  }

}
