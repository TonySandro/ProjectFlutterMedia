import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'olá': HighlightedWord(
      onTap: () => print('Olá'),
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.orange,
        fontWeight: FontWeight.bold,
      ),
    ),
    'Cláudio': HighlightedWord(
      onTap: () => print('Cláudio'),
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'mundo': HighlightedWord(
      onTap: () => print('mundo,'),
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'Professor': HighlightedWord(
      onTap: () => print('Professor'),
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'aplicativo': HighlightedWord(
      onTap: () => print('aplicativo'),
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
      ),
    ),
    'Tony': HighlightedWord(
      onTap: () => print('Tony'),
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'Rodrigo': HighlightedWord(
      onTap: () => print('Rodrigo'),
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Precione o botão e comece a falar";
  // ignore: unused_field
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
        title: Text("Voice Recognition"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        repeatPauseDuration: const Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
        child: TextHighlight(
          text: _text,
          words: _highlights,
          textStyle: const TextStyle(
            fontSize: 32.0,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
