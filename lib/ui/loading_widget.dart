import 'package:flutter/material.dart';
import 'dart:async'; // 타이머를 사용하기 위해 추가
import 'package:lottie/lottie.dart'; // Lottie 애니메이션 패키지 추가
import 'placeselect_widget.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final maxWidth = 400.0; // 화면의 최대 너비 설정
  final maxHeight = 900.0; // 화면의 최대 높이 설정

  @override
  void initState() {
    super.initState();
    // 5초 후 다음 페이지로 이동
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PlaceSelectWidget()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double queryWidth = MediaQuery.of(context).size.width;
    if (queryWidth > maxWidth) {
      queryWidth = maxWidth;
    }
    double queryHeight = MediaQuery.of(context).size.height;
    if (queryHeight > maxHeight) {
      queryHeight = maxHeight;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // 뒤로 가기 아이콘 색상을 흰색으로 설정
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF151519), // 앱바 배경색을 설정
      ),
      backgroundColor: Color(0xFF151519), // 배경색을 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLottieAnimation(), // Lottie 애니메이션 생성
            SizedBox(height: 20),
            _buildLoadingText(), // 로딩 텍스트 생성
            SizedBox(height: 10),
            _buildDotsText(), // 점 점 점 텍스트 생성
          ],
        ),
      ),
    );
  }

  // Lottie 애니메이션 위젯 생성
  Widget _buildLottieAnimation() {
    return Container(
      width: 250,
      height: 250, // 크기를 키움
      padding: const EdgeInsets.all(15), // 약간의 여백을 추가하여 테두리를 잘라냄
      child: Lottie.asset('assets/animation_gps.json'), // Lottie 애니메이션 파일 경로
    );
  }

  // 로딩 텍스트 위젯 생성
  Widget _buildLoadingText() {
    return Text(
      '현위치 탐색 중',
      style: TextStyle(
        fontWeight: FontWeight.w900, // 더욱 굵게 설정
        fontSize: 18,
        color: Colors.white, // 텍스트 색상을 흰색으로 설정
      ),
    );
  }

  // 점 점 점 텍스트 위젯 생성
  Widget _buildDotsText() {
    return Text(
      '...',
      style: TextStyle(
        fontSize: 24,
        color: Colors.white, // 텍스트 색상을 흰색으로 설정
      ),
    );
  }
}
