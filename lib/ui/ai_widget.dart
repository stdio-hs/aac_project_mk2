import 'package:aac_project_mk2/bloc/stt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'ai_output_widget.dart';
import 'stt_widget.dart'; // SttWidget 파일 import

class AiWidget extends StatefulWidget {
  final String text;
  final String translated;

  AiWidget({required this.text, required this.translated});

  @override
  _AiWidgetState createState() => _AiWidgetState();
}

class _AiWidgetState extends State<AiWidget> {
  final SttController controller = Get.put(SttController());
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<String> sentences = widget.translated
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((sentence) => sentence.trim())
        .toList();

    List<String> extendedSentences = [
      sentences.last,
      ...sentences,
      sentences.first,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.25,
              child: Lottie.asset('assets/animation_ai.json'),
            ),
            SizedBox(height: screenHeight * 0.03),
            _buildTitle(screenWidth),
            SizedBox(height: screenHeight * 0.005),
            _buildSubtitle(screenWidth),
            SizedBox(height: screenHeight * 0.005),
            _buildResultSlider(extendedSentences, context, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.2),
            _buildRetryButton(context, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(double screenWidth) {
    return Text(
      '[ AI가 추천해주는 응답 모음 ]',
      style: TextStyle(fontSize: screenWidth * 0.035,  fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _buildSubtitle(double screenWidth) {
    return Text(
      '질문 : ${widget.text}',
      style: TextStyle(fontSize: screenWidth * 0.025, color: Colors.grey),
    );
  }

  Widget _buildResultSlider(List<String> extendedSentences, BuildContext context, double screenWidth, double screenHeight) {
    return Expanded(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 28, color: Colors.black),
            onPressed: () {
              _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });

                // Infinite loop functionality
                if (index == 0) {
                  Future.delayed(Duration(milliseconds: 300), () {
                    _pageController.jumpToPage(extendedSentences.length - 2);
                  });
                } else if (index == extendedSentences.length - 1) {
                  Future.delayed(Duration(milliseconds: 300), () {
                    _pageController.jumpToPage(1);
                  });
                }
              },
              itemCount: extendedSentences.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AiOutputWidget(sentence: extendedSentences[index]),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.4,
                        padding: EdgeInsets.all(screenWidth * 0.04),
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
                        child: Center(
                          child: Text(
                            extendedSentences[index],
                            style: TextStyle( fontWeight: FontWeight.bold, fontSize: screenWidth * 0.07, color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              pageSnapping: true,
              physics: PageScrollPhysics(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 28, color: Colors.black),
            onPressed: () {
              _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context, double screenWidth) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.resetData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SttWidget()),
          );
        },
        child: Text('다시 답변하기', style: TextStyle(fontSize: screenWidth * 0.03)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Background color
          foregroundColor: Colors.white, // Text color
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenWidth * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
