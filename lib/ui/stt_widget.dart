// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'ai_widget.dart'; // ai_widget 파일 import
// import 'aac_output_widget.dart'; // FinalOutputPage 파일 import
// import 'home_widget.dart'; // home_widget 파일 impovhrt
// import 'dart:io';
// import 'dart:convert';
//
// class SttWidget extends StatefulWidget {
//   @override
//   _SttWidgetState createState() => _SttWidgetState();
// }
//
// class _SttWidgetState extends State<SttWidget> {
//   bool isListening = false;
//   late stt.SpeechToText _speech;
//   String _text = '';
//
//   Socket? _socket;
//   final TextEditingController _controller = TextEditingController();
//   String _response = '';
//   String _wow='';
//
//
//   @override
//   void initState() {
//     super.initState();
//     _connectToServer();
//     _speech = stt.SpeechToText();
//     requestPermissions();
//   }
//   void _connectToServer() async {
//     try {
//       _socket = await Socket.connect('10.0.2.2', 5000); // Android 에뮬레이터에서는 127.0.0.1 대신 10.0.2.2 사용
//       _socket!.listen((data) {
//         final serverResponse = utf8.decode(data);
//         setState(() {
//           // _response = String.fromCharCodes(data);
//           _response = serverResponse;
//         });
//         print('서버 응답: $serverResponse');
//       }, onError: (error) {
//         print("Socket error: $error");
//         _socket?.destroy();
//       }, onDone: () {
//         print("Socket connection closed");
//         _socket?.destroy();
//       });
//     } catch (e) {
//       print("Unable to connect: $e");
//     }
//   }
//
//   void _sendMessage(String message) {
//     if (_socket != null && _socket!.remoteAddress != null) {
//       final protocolMessage = 'REQUEST 2023-01-01 analysis $message';
//       _socket!.write(protocolMessage);
//     } else {
//       print("Socket is not connected");
//     }
//   }
//
//   @override
//   void dispose() {
//     _socket?.close();
//     super.dispose();
//   }
//
//   void requestPermissions() async {
//     var status = await Permission.microphone.status;
//     if (!status.isGranted) {
//       status = await Permission.microphone.request();
//     }
//
//     if (!status.isGranted) {
//       print('Microphone permission denied');
//     } else {
//       print('Microphone permission granted');
//     }
//   }
//
//   void startListening() async {
//     print('Start listening');
//     bool available = await _speech.initialize(
//       onStatus: (status) => print('onStatus: $status'),
//       onError: (errorNotification) => print('onError: $errorNotification'),
//     );
//
//     if (available) {
//       setState(() => isListening = true);
//       _speech.listen(
//         onResult: (result) {
//           setState(() {
//             _text = result.recognizedWords;
//             print('Recognized Words: $_text');
//           });
//           _translateText(_text);
//         },
//         localeId: 'ko_KR',
//       );
//     } else {
//       setState(() => isListening = false);
//       print('Speech recognition not available: $_speech');
//     }
//   }
//
//   void stopListening() {
//     print('Stop listening');
//     _speech.stop();
//     if (mounted) {
//       setState(() {
//         isListening = false;
//         _sendMessage(_text);
//         print(_response);
//       });
//     }
//     // 다음 페이지로 이동 (인식된 텍스트 전달)
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AiWidget(text: _text, translated: _response)),
//     );
//   }
//
//   void _translateText(String text) async {
//     String translated = await translate(text);
//     if (mounted) {
//       setState(() {
//         _response = translated;
//       });
//     }
//   }
//
//   Future<String> translate(String text) async {
//     await Future.delayed(Duration(seconds: 1));
//     return _response;
//   }
//
//
//   void navigateToFinalOutputPage() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => FinalOutputPage(selectedNodes: [])), // 전달할 selectedNodes 필요
//     );
//   }
//
//   void navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => HomeWidget()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: navigateToFinalOutputPage,
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.home, color: Colors.white),
//             onPressed: navigateToHome,
//           ),
//         ],
//       ),
//       backgroundColor: Color(0xFF151519),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: isListening ? stopListening : startListening,
//               child: CircleAvatar(
//                 radius: 120, // 동그라미 사이즈를 크게 설정
//                 backgroundColor: Colors.blue,
//                 child: isListening
//                     ? Lottie.asset(
//                   'assets/animation_stt.json',
//                   repeat: true,
//                   width: 240, // stt_animation의 크기를 더 크게 설정
//                   height: 240, // stt_animation의 크기를 더 크게 설정
//                 )
//                     : Container(),
//               ),
//             ),
//             SizedBox(height: 20),
//             isListening
//                 ? ElevatedButton(
//               onPressed: stopListening,
//               child: Text('STOP'),
//             )
//                 : Text(
//               '눌러서 질문해주세요',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:aac_project_mk2/bloc/stt_controller.dart';
import 'ai_widget.dart'; // ai_widget 파일 import
import 'aac_output_widget.dart'; // FinalOutputPage 파일 import
import 'home_widget.dart'; // home_widget 파일 import

class SttWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SttController controller = Get.put(SttController());

    String completed(SttController controller){
        if(controller.text.value.isEmpty){
          return '';
        }
        else if(controller.analy.value){
          return '완료됨';
        }
        else{
          return '분석중';
        }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FinalOutputPage(selectedNodes: [])),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeWidget()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF151519),
      body: Center(
        child: Obx(() {
          if (controller.isListening.value) {
            return GestureDetector(
              onTap: controller.stopListening,
              child: CircleAvatar(
                radius: 120, // 동그라미 사이즈를 크게 설정
                backgroundColor: Colors.blue,
                child: Lottie.asset(
                  'assets/animation_stt.json',
                  repeat: true,
                  width: 240, // stt_animation의 크기를 더 크게 설정
                  height: 240, // stt_animation의 크기를 더 크게 설정
                ),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: controller.startListening,
                  child: CircleAvatar(
                    radius: 120, // 동그라미 사이즈를 크게 설정
                    backgroundColor: Colors.blue,
                    child: Text(
                      '눌러서 질문해주세요',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AiWidget(
                          text: controller.text.value,
                          translated: controller.response.value,
                        ),
                      ),
                    );
                  },
                  child: Text('AI Page로 이동'),
                ),
                Text(
                  '질문 : ${controller.text.value}\n',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  completed(controller),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            );
          }
        }),
      ),
    );
  }
}
