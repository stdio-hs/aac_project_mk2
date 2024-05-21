import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'ai_widget.dart'; // ai_widget 파일 import
import 'aac_output_widget.dart'; // FinalOutputPage 파일 import
import 'home_widget.dart'; // home_widget 파일 import

class SttWidget extends StatefulWidget {
  @override
  _SttWidgetState createState() => _SttWidgetState();
}

class _SttWidgetState extends State<SttWidget> {
  bool isListening = false;

  void startListening() {
    setState(() {
      isListening = true;
    });
  }

  void stopListening() {
    setState(() {
      isListening = false;
    });

    // 다음 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AiWidget()),
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
