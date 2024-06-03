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
        return '완료됨';
      } else {
        return 'AI가 추천답변을 찾고있어요';
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
                      radius: 120, // 동그라미 사이즈를 크게 설정
                      backgroundColor: Colors.blue,
                      child: Text(
                        '눌러서 질문해주세요',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                if (controller.text.value.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        completed(controller),
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '질문 : ${controller.text.value}\n',
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
