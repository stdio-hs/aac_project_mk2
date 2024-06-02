import 'package:aac_project_mk2/bloc/stt_controller.dart';
import 'package:aac_project_mk2/ui/stt_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';

class AiWidget extends StatelessWidget {
  final String text;
  final String translated;
  AiWidget({required this.text, required this.translated});

  @override
  Widget build(BuildContext context) {
    final SttController controller = Get.put(SttController());

    return Scaffold(
        appBar: AppBar(title: Text('AI Page'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
                  controller.resetData();
                  Navigator.pop(context);
            },
          ),),
        body: Center(
            child: Text(
              '질문 : ${text}\n'
                  '분석 결과 : ${translated}',
              style: TextStyle(fontSize: 24),
            )
        )
    );
  }
}
// class AiWidget extends StatefulWidget {
//   final String text;
//   final String translated;
//
//   const AiWidget({required this.text, required this.translated, super.key});
//
//   @override
//   State<AiWidget> createState() => _AiWidgetState();
// }
//
// class _AiWidgetState extends State<AiWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final SttController controller = Get.find();
//
//     return Scaffold(
//       appBar: AppBar(title: Text('AI Page'),
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: (){
//           controller.resetData();
//           Get.back();
//         },
//       ),),
//       body: Center(
//         child: Text(
//           '질문 : ${widget.text}\n'
//               '답변 : ${widget.translated}',
//           style: TextStyle(fontSize: 24),
//     )
//     )
//     );
//   }
// }
