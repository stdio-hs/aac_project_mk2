import 'package:flutter/material.dart';
import 'common_widgets.dart';

class DetailSelectWidget extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  DetailSelectWidget({required this.categoryName, required this.categoryImage});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: _buildBackButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryLabel(screenWidth),
            SizedBox(height: 20),
            Expanded(child: _buildGrid()),
            SizedBox(height: 20),
            _buildCompleteButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildCategoryLabel(double screenWidth) {
    return Row(
      children: [
        Image.asset(
          categoryImage,
          height: screenWidth * 0.8, // Adjust image size based on screen width
        ),
        SizedBox(width: 10),
        Text(
          categoryName,
          style: TextStyle(
            fontSize: screenWidth * 0.5, // Adjust font size based on screen width
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 9, // 임시로 9개의 빈 박스 생성
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = constraints.maxWidth;
            double itemHeight = constraints.maxHeight;
            double textSize = itemWidth * 0.15; // Adjust text size based on item size

            return Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '임시 박스',
                  style: TextStyle(
                    fontSize: textSize, // Adjust font size based on item size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCompleteButton() {
    return Center(
      child: CustomButton(
        text: '선택 완료',
        onPressed: () {
          // 선택 완료 버튼 클릭시 아무런 액션 없음
        },
      ),
    );
  }
}
