import 'package:flutter/material.dart';
import 'loading_widget.dart';
import 'detailselect_widget.dart';
import 'common_widgets.dart';

class PlaceSelectWidget extends StatelessWidget {
  final List<Map<String, String>> places = [
    {'name': '카페', 'image': 'assets/cafe.png'},
    {'name': '식당', 'image': 'assets/restaurant.png'},
    {'name': '마트', 'image': 'assets/mart.png'},
    {'name': '편의점', 'image': 'assets/convenience_store.png'},
    {'name': '문구점', 'image': 'assets/stationery_store.png'},
    {'name': '서점', 'image': 'assets/bookstore.png'},
    {'name': '도서관', 'image': 'assets/library.png'},
    {'name': '미용실', 'image': 'assets/hairdresser.png'},
    {'name': '영화관', 'image': 'assets/cinema.png'},
    {'name': '병원', 'image': 'assets/hospital.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            _buildTitle(),
            SizedBox(height: 8),
            _buildSubtitle(),
            SizedBox(height: 20),
            Expanded(child: _buildPlaceGrid(context)),
            SizedBox(height: 20),
            _buildRetryButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '원하시는 장소의 카테고리를 선택해주세요',
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      '현위치 주변 장소 카테고리 입니다.',
      style: TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  Widget _buildPlaceGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailSelectWidget(
                  categoryName: places[index]['name']!,
                  categoryImage: places[index]['image']!,
                ),
              ),
            );
          },
          child: _buildPlaceCard(places[index]),
        );
      },
    );
  }

  Widget _buildPlaceCard(Map<String, String> place) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              place['image']!,
              height: 50,
            ),
            SizedBox(height: 10),
            Text(
              place['name']!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return Center(
      child: CustomButton(
        text: '다시 탐색하기',
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoadingWidget()),
          );
        },
      ),
    );
  }
}
