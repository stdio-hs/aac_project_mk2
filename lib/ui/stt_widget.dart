import 'package:flutter/material.dart';
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

    void navigateToAiPage() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AiWidget(
            text: controller.text.value,
            translated: controller.response.value,
          ),
        ),
      );
    }

    String completed(SttController controller) {
      if (controller.text.value.isEmpty) {
        return '';
      } else if (controller.analy.value) {
        return '';
      } else {
        return '★ AI가 추천 응답을 찾고 있어요 ★';
      }
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                radius: screenWidth, // 동그라미 사이즈를 화면 너비에 비례하여 설정
                backgroundColor: Colors.transparent,
                child: Container(
                  width: screenWidth * 1, // stt_animation의 크기를 화면 너비에 비례하여 설정
                  height: screenWidth * 1, // stt_animation의 크기를 화면 너비에 비례하여 설정
                  child: Lottie.asset(
                    'assets/animation_stt.json',
                    repeat: true,
                  ),
                ),
              ),
            );
          } else {
            if (controller.analy.value && controller.response.value.isNotEmpty) {
              // 분석이 완료되고 응답이 있으면 AiWidget 페이지로 이동
              Future.delayed(Duration.zero, () => navigateToAiPage());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.text.value.isEmpty)
                  GestureDetector(
                    onTap: controller.startListening,
                    child: CircleAvatar(
                      radius: screenWidth * 0.2, // 동그라미 사이즈를 화면 너비에 비례하여 설정
                      backgroundColor: Colors.blue,
                      child: Text(
                        '눌러서 질문해주세요',
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.03), // 텍스트 크기를 화면 너비에 비례하여 설정
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                if (controller.text.value.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        completed(controller),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: screenWidth * 0.06, // 화면 너비에 비례하여 텍스트 크기 조정
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '질문 : ${controller.text.value}\n',
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.035), // 텍스트 크기를 화면 너비에 비례하여 설정
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              ],
            );
          }
        }),
      ),
    );
  }
}
