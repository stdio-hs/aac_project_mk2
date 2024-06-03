import 'package:aac_project_mk2/bloc/stt_controller.dart';
import 'package:aac_project_mk2/ui/stt_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiWidget extends StatelessWidget {
  final String text;
  final String translated;
  AiWidget({required this.text, required this.translated});

  @override
  Widget build(BuildContext context) {
    final SttController controller = Get.put(SttController());

    return Scaffold(
      appBar: AppBar(
        title: Text('AI Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            controller.resetData();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          '질문 : $text\n분석 결과 키값 : $translated',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
