// 장소카테고리 선택 (트리구조 시작)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_loader.dart';
import 'tree_view.dart';
import 'common_widgets.dart';
import 'loading_widget.dart';

class PlaceSelectWidget extends StatelessWidget {
  final List<Map<String, String>> places = [
    {'name': '카페', 'image': 'assets/cafe.png', 'id': '106'},
    {'name': '식당', 'image': 'assets/restaurant.png', 'id': '109'},
    {'name': '마트', 'image': 'assets/mart.png', 'id': '104'},
    {'name': '편의점', 'image': 'assets/convenience_store.png', 'id': '101'},
    {'name': '문구점', 'image': 'assets/stationery_store.png', 'id': '102'},
    {'name': '서점', 'image': 'assets/bookstore.png', 'id': '107'},
    {'name': '도서관', 'image': 'assets/library.png', 'id': '105'},
    {'name': '미용실', 'image': 'assets/hairdresser.png', 'id': '108'},
    {'name': '영화관', 'image': 'assets/cinema.png', 'id': '103'},
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
                  ),
                ),
              );
            } else {
              print('No nodes found for the selected place.');
            }
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
