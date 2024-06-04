import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_loader.dart';
import 'tree_view.dart';
import 'common_widgets.dart';
import 'loading_widget.dart';

class PlaceSelectWidget extends StatelessWidget {
  final List<Map<String, String>> places = [
    {'name': '식당', 'image': 'assets/restaurant.png', 'id': '102'},
    {'name': '마트', 'image': 'assets/mart.png', 'id': '104'},
    {'name': '편의점', 'image': 'assets/convenience_store.png', 'id': '105'},
    {'name': '문구점', 'image': 'assets/stationery_store.png', 'id': '101'},
    {'name': '서점', 'image': 'assets/bookstore.png', 'id': '109'},
    {'name': '도서관', 'image': 'assets/library.png', 'id': '106'},
    {'name': '미용실', 'image': 'assets/hairdresser.png', 'id': '108'},
    {'name': '영화관', 'image': 'assets/cinema.png', 'id': '103'},
    {'name': '카페', 'image': 'assets/cafe.png', 'id': '107'}
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double aspectRatio = screenWidth / screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            _buildTitle(screenWidth),
            SizedBox(height: 8),
            _buildSubtitle(screenWidth),
            SizedBox(height: 20),
            Expanded(child: _buildPlaceGrid(context, aspectRatio)),
            SizedBox(height: 20),
            _buildRetryButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(double screenWidth) {
    return Text(
      '원하시는 장소의 카테고리를 선택해주세요',
      style: TextStyle(
        fontSize: screenWidth * 0.035,  // Adjust font size based on screen width
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle(double screenWidth) {
    return Text(
      '현위치 주변 장소 카테고리 입니다.',
      style: TextStyle(
        fontSize: screenWidth * 0.03,  // Adjust font size based on screen width
        color: Colors.grey,
      ),
    );
  }

  Widget _buildPlaceGrid(BuildContext context, double aspectRatio) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: aspectRatio > 1.5 ? 4 : 2,  // Adjust crossAxisCount based on aspect ratio
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = constraints.maxWidth;
            double itemHeight = constraints.maxHeight;
            double imageHeight = itemWidth * 0.4;
            double textSize = itemWidth * 0.08;

            return GestureDetector(
              onTap: () async {
                var dataLoader = Provider.of<DataLoader>(context, listen: false);
                var nodeId = int.parse(places[index]['id']!);
                var node = dataLoader.getNodesById([nodeId]).first;
                if (node['node'].isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TreeView(
                        initialNodeId: nodeId,
                        selectedNodes: [places[index]['name']!],
                        initialNodes: node['node'].cast<int>(),
                        placeName: places[index]['name']!,
                        placeImage: places[index]['image']!,
                      ),
                    ),
                  );
                } else {
                  print('No nodes found for the selected place.');
                }
              },
              child: _buildPlaceCard(places[index], imageHeight, textSize),
            );
          },
        );
      },
    );
  }

  Widget _buildPlaceCard(Map<String, String> place, double imageHeight, double textSize) {
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
              height: imageHeight,  // Adjust image size based on item size
            ),
            SizedBox(height: 10),
            Text(
              place['name']!,
              style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),  // Adjust text size based on item size
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
