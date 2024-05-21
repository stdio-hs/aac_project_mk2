import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'ai_widget.dart'; // ai_widget 파일 import
import 'aac_output_widget.dart'; // FinalOutputPage 파일 import
import 'home_widget.dart'; // home_widget 파일 impovhrt

class SttWidget extends StatefulWidget {
  @override
  _SttWidgetState createState() => _SttWidgetState();
}

class _SttWidgetState extends State<SttWidget> {
  bool isListening = false;
  late stt.SpeechToText _speech;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    requestPermissions();
  }

  void requestPermissions() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (!status.isGranted) {
      print('Microphone permission denied');
    } else {
      print('Microphone permission granted');
    }
  }

  void startListening() async {
    print('Start listening');
    bool available = await _speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (errorNotification) => print('onError: $errorNotification'),
    );

    if (available) {
      setState(() => isListening = true);
      _speech.listen(
        onResult: (result) => setState(() {
          _text = result.recognizedWords;
          print('Recognized Words: $_text');
        }),
      );
    } else {
      setState(() => isListening = false);
      print('Speech recognition not available: $_speech');
    }
  }

  void stopListening() {
    print('Stop listening');
    _speech.stop();
    setState(() => isListening = false);

    // 다음 페이지로 이동 (인식된 텍스트 전달)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AiWidget(text: _text)),
    );
  }

  void navigateToFinalOutputPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FinalOutputPage(selectedNodes: [])), // 전달할 selectedNodes 필요
    );
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: navigateToFinalOutputPage,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: navigateToHome,
          ),
        ],
      ),
      backgroundColor: Color(0xFF151519),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: isListening ? stopListening : startListening,
              child: CircleAvatar(
                radius: 120, // 동그라미 사이즈를 크게 설정
                backgroundColor: Colors.blue,
                child: isListening
                    ? Lottie.asset(
                  'assets/animation_stt.json',
                  repeat: true,
                  width: 240, // stt_animation의 크기를 더 크게 설정
                  height: 240, // stt_animation의 크기를 더 크게 설정
                )
                    : Container(),
              ),
            ),
            SizedBox(height: 20),
            isListening
                ? ElevatedButton(
              onPressed: stopListening,
              child: Text('STOP'),
            )
                : Text(
              '눌러서 질문해주세요',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
