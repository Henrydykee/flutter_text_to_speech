import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  stt.SpeechToText _speech;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        duration: Duration(milliseconds: 2000),
        repeatPauseDuration:  Duration(microseconds: 100),
        endRadius: 75.0,
        child: FloatingActionButton(
          onPressed: () {
            _listen();
          },
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Center(child: Text(_text,style: TextStyle(
          color: Colors.black,
          fontSize: 16
        ),)),
      ),
    );
  }

  void _listen() async {
    if(!_isListening )  {
      bool available = await _speech.initialize(
        onStatus: (val) => print("onstatus: $val"),
          onError: (val) => print("onstatus: $val")
      );
      if(available){
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) =>  setState(() {
            _text = val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence > 0){
              _confidence  = val.confidence;
            }
          })
        );
      }
    }else{
      setState(() {
        _isListening  = false;
        _speech.stop();
      });
    }
  }
}


