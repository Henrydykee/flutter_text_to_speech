import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt ;

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  stt.SpeechToText  _speech;
  bool _isListening = false;
  String _text = "press the button to start speeaking";
  double _confidence = 1.0;

  

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
