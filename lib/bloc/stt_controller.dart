import 'package:get/get.dart';
import 'dart:io';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SttController extends GetxController {
  var isListening = false.obs;
  var text = ''.obs;
  var response = ''.obs;
  var analy = false.obs;

  late stt.SpeechToText _speech;
  Socket? _socket;

  @override
  void onInit() {
    super.onInit();
    _speech = stt.SpeechToText();
    _connectToServer();
    requestPermissions();
  }

  void requestPermissions() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (!status.isGranted) {
      Get.snackbar('Error', 'Microphone permission denied');
    } else {
      Get.snackbar('Success', 'Microphone permission granted');
    }
  }

  void _connectToServer() async {
    try {
      _socket = await Socket.connect('165.229.180.132', 5000); // Android 에뮬레이터에서는 127.0.0.1 대신 10.0.2.2 사용

      _socket!.listen((data) {
        final serverResponse = utf8.decode(data);
        analy.value = true;
        response.value = serverResponse;
        print('서버 응답: $serverResponse');
      }, onError: (error) {
        print("Socket error: $error");
        _socket?.destroy();
      }, onDone: () {
        print("Socket connection closed");
        _socket?.destroy();
      });
    } catch (e) {
      print("Unable to connect: $e");
    }
  }

  void sendMessage(String message) {
    if (_socket != null && _socket!.remoteAddress != null) {
      final protocolMessage = 'REQUEST 2023-01-01 analysis $message';
      _socket!.write(protocolMessage);
    } else {
      Get.snackbar('Error', "Socket is not connected");
    }
  }

  void stopListening() {
    print('Stop listening');
    _speech.stop();
    isListening.value = false;
  }

  void startListening() async {
    print('Start listening');
    bool available = await _speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (errorNotification) => print('onError: $errorNotification'),
    );

    if (available) {
      isListening.value = true;
      _speech.listen(
        onResult: (result) {
          text.value = result.recognizedWords;
          print('Recognized Words: ${text.value}');
          if(result.finalResult){
            sendMessage(text.value); // 음성 인식된 텍스트를 서버로 전송
            stopListening();
          }

        },
        listenMode: stt.ListenMode.dictation,
        localeId: 'ko_KR',
      );
    } else {
      isListening.value = false;
      Get.snackbar('Error', 'Speech recognition not available');
    }
  }
  void resetData() {
    text.value = '';
    analy.value = false;
    response.value = '';
  }
  @override
  void onClose() {
    _socket?.close();
    super.onClose();
  }
}
