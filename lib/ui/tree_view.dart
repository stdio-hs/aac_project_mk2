import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_loader.dart';
import 'common_widgets.dart';
import 'aac_output_widget.dart';

/// TreeView 메인 화면
class TreeView extends StatelessWidget {
  final int initialNodeId;
  final List<String> selectedNodes;
  final List<int> initialNodes;
  final String placeName;
  final String placeImage;
  
  TreeView({
    required this.initialNodeId,
    required this.selectedNodes,
    required this.initialNodes,
    required this.placeName,
    required this.placeImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _buildBackButton(context),
      ),
      body: Consumer<DataLoader>(
        builder: (context, dataLoader, child) {
          if (dataLoader.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              CategoryLabel(
                categoryName: placeName,
                categoryImage: placeImage,
              ),
              if (selectedNodes.isNotEmpty)
                SelectedNodesWidget(selectedNodes: selectedNodes),
              Expanded(
                child: NodeList(
                  nodes: dataLoader.getNodesById(initialNodes),
                  selectedNodes: selectedNodes,
                  placeName: placeName,
                  placeImage: placeImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalOutputPage(
                          selectedNodes: selectedNodes,
                        ),
                      ),
                    );
                  },
                  child: Text('선택 완료', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          );
        },
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
}

/// 카테고리 라벨 위젯
class CategoryLabel extends StatelessWidget {
  final String categoryName;
  final String categoryImage;

  CategoryLabel({required this.categoryName, required this.categoryImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image.asset(
            categoryImage,
            height: 50,
          ),
          SizedBox(width: 10),
          Text(
            categoryName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

/// 선택된 노드 위젯
class SelectedNodesWidget extends StatelessWidget {
  final List<String> selectedNodes;

  SelectedNodesWidget({required this.selectedNodes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        selectedNodes.join(' > '),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// 노드 리스트 위젯
class NodeList extends StatelessWidget {
  final List<dynamic> nodes;
  final List<String> selectedNodes;
  final String placeName;
  final String placeImage;

  NodeList({
    required this.nodes,
    required this.selectedNodes,
    required this.placeName,
    required this.placeImage,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        var node = nodes[index];
        return GestureDetector(
          onTap: () => _handleNodeTap(context, node),
          child: NodeCard(node: node),
        );
      },
    );
  }

  void _handleNodeTap(BuildContext context, dynamic node) {
    if (node['node'].isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NodeDetails(
            nodeId: node['id'],
            nodeName: node['name'],
            children: node['node'],
            selectedNodes: List.from(selectedNodes)..add(node['name']),
            placeName: placeName,
            placeImage: placeImage,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinalOutputPage(
            selectedNodes: List.from(selectedNodes)..add(node['name']),
          ),
        ),
      );
    }
  }
}

/// 노드 카드 위젯
class NodeCard extends StatelessWidget {
  final dynamic node;

  NodeCard({required this.node});

  @override
  Widget build(BuildContext context) {
    // 노드 번호에 따라 이미지 URL을 생성합니다.
    final imageUrl = 'http://15.164.48.193/images/${node['id']}.png';

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
            // 서버에서 이미지를 가져와 표시합니다.
            Image.network(imageUrl, height: 50),
            SizedBox(height: 10),
            Text(
              node['name'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================================
/// 트리구조 알고리즘 파트
/// =====================================

/// 노드 상세 화면
class NodeDetails extends StatelessWidget {
  final int nodeId;
  final String nodeName;
  final List<dynamic> children;
  final List<String> selectedNodes;
  final String placeName;
  final String placeImage;

  NodeDetails({
    required this.nodeId,
    required this.nodeName,
    required this.children,
    required this.selectedNodes,
    required this.placeName,
    required this.placeImage,
  });

  @override
  Widget build(BuildContext context) {
    var dataLoader = Provider.of<DataLoader>(context);
    var childNodes = dataLoader.getNodesById(children.cast<int>());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _buildBackButton(context),
      ),
      body: Column(
        children: [
          CategoryLabel(
            categoryName: placeName,
            categoryImage: placeImage,
          ),
          if (selectedNodes.isNotEmpty)
            SelectedNodesWidget(selectedNodes: selectedNodes),
          Expanded(
            child: NodeList(
              nodes: childNodes,
              selectedNodes: selectedNodes,
              placeName: placeName,
              placeImage: placeImage,
            ),
          ),
        ],
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
}
