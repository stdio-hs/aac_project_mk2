import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'placeselect_widget.dart'; // 장소선택카테고리 페이지 import
import 'stt_widget.dart'; // STT 페이지 import

class FinalOutputPage extends StatelessWidget {
  final List<String> selectedNodes;

  FinalOutputPage({required this.selectedNodes});

  @override
  Widget build(BuildContext context) {
    final childNodes = selectedNodes.skip(2).join(' ');

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: RotatedText(childNodes: childNodes),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ButtonRow(),
          ),
        ],
      ),
    );
  }
}

class RotatedText extends StatelessWidget {
  final String childNodes;

  RotatedText({required this.childNodes});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.width,
        child: FittedBox(
          fit: BoxFit.contain,
          child: AutoSizeText(
            childNodes,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
              fontFamily: 'Courier',
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 10,
            stepGranularity: 0.5,
          ),
        ),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PlaceSelectWidget()),
                  (Route<dynamic> route) => false,
            );
          },
          child: Text(
            '다시 선택하기',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SttWidget()),
            );
          },
          child: Text(
            '답변하기',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
