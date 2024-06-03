import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AiOutputWidget extends StatelessWidget {
  final String sentence;

  AiOutputWidget({required this.sentence});

  @override
  Widget build(BuildContext context) {
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
              child: RotatedText(childNodes: sentence),
            ),
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
