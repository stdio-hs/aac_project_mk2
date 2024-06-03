import 'package:aac_project_mk2/bloc/stt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ai_output_widget.dart';
import 'stt_widget.dart'; // SttWidget 파일 import

class AiWidget extends StatelessWidget {
  final String text;
  final String translated;
  final SttController controller = Get.put(SttController());

  AiWidget({required this.text, required this.translated});

  @override
  Widget build(BuildContext context) {
    List<String> sentences = translated
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((sentence) => sentence.trim())
        .toList();

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
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildTitle(),
            SizedBox(height: 8),
            _buildSubtitle(),
            SizedBox(height: 20),
            Expanded(child: _buildResultList(sentences, context)),
            SizedBox(height: 20),
            _buildRetryButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'AI가 추천해주는 답변입니다.',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      '질문: $text',
      style: TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  Widget _buildResultList(List<String> sentences, BuildContext context) {
    return ListView.builder(
      itemCount: sentences.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AiOutputWidget(sentence: sentences[index]),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                sentences[index],
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.resetData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SttWidget()),
          );
        },
        child: Text('다시 답변하기'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Background color
          foregroundColor: Colors.white, // Text color
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
