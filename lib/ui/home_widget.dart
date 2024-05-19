// APP 실행시 처음 뜨는 화면

import 'package:flutter/material.dart';
import 'loading_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  var _style = HomeScaffoldTheme();
  final maxWidth = 400.0;
  final maxHeight = 900.0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      body: Stack(
        children: [
          Container(
            width: queryWidth,
            height: queryHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0f0c29), Color(0xFF302b63)], // 어두운 네이비 그라데이션 색상
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/3d_image.png', // 3D 이미지 경로
                height: queryHeight * 0.7, // 이미지 높이를 화면 높이의 70%로 설정
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SMART AAC',
                    style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.bold, // 볼드체로 설정
                      fontFamily: 'Montserrat',
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Alternative Augmentative Communication',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildStartButton(),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 40, // 상단 패딩 추가
            child: Column(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    '언어장애인을 위한 보완대체의사소통 APP',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 30,
                  height: 5,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoadingWidget()), // 버튼 클릭 시 LoadingWidget으로 이동
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent, // 버튼 배경색을 파란색으로 설정
        foregroundColor: Colors.white, // 버튼 텍스트 색상
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'START',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class HomeScaffoldTheme {
  Color getMainWhite() {
    return Colors.white; // 기본 배경색 반환
  }
}
