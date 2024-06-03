import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_loader.dart';
import 'common_widgets.dart';
import 'aac_output_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataLoader(),
      child: MaterialApp(
        home: TreeView(
          initialNodeId: 1,
          selectedNodes: [],
          initialNodes: [1, 2, 3],
          placeName: 'Place Name',
          placeImage: 'assets/images/place_image.png', // Example path
        ),
      ),
    );
  }
}

class DataLoader extends ChangeNotifier {
  dynamic data;

  DataLoader() {
    // Load your data here
    data = loadData();
  }

  dynamic loadData() {
    // Simulate loading data
    return {
      1: {'id': 1, 'name': 'Node 1', 'node': []},
      2: {'id': 2, 'name': 'Node 2', 'node': []},
      3: {'id': 3, 'name': 'Node 3', 'node': []},
    };
  }

  List<dynamic> getNodesById(List<int> ids) {
    return ids.map((id) => data[id]).toList();
  }
}


/// TreeView 메인 화면
class TreeView extends StatelessWidget {
  final int initialNodeId;
  final List<String> selectedNodes;
  final List<int> initialNodes;
  final String placeName;
  final String placeImage;
<<<<<<< Updated upstream
  
=======

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
                nodeID: initialNodeId.toString(),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
>>>>>>> Stashed changes
            ],
          );
        },
      ),
    );
  }
<<<<<<< Updated upstream

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
=======

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
>>>>>>> Stashed changes
      },
    );
  }
}

class CategoryLabel extends StatelessWidget {
  final String nodeID;
  final String categoryName;
  final String categoryImage;

  CategoryLabel({required this.nodeID, required this.categoryName, required this.categoryImage});

<<<<<<< Updated upstream
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

=======
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
        return NodeCard(node: node);
      },
    );
  }
}

class NodeCard extends StatelessWidget {
  final dynamic node;

  NodeCard({required this.node});

  @override
  Widget build(BuildContext context) {
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
            // 서버에서 이미지를 가져와 표시합니다.
            Image.network(imageUrl, height: 50),
=======
            Image.network('http://15.164.48.193/images/${node['id'].toString()}.png'),
>>>>>>> Stashed changes
            SizedBox(height: 10),
            Text(
              node['name'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
<<<<<<< Updated upstream
            ),
          ],
        ),
      ),
=======
            ),
          ],
        ),
      ),
    );
  }
}

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
>>>>>>> Stashed changes
    );
  }
}

<<<<<<< Updated upstream
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

=======
class PlaceSelectWidget extends StatelessWidget {
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    // Replace with your actual implementation
    return Scaffold(
<<<<<<< Updated upstream
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
=======
      appBar: AppBar(title: Text('Place Select')),
      body: Center(child: Text('Place Select Page')),
    );
  }
}

class SttWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with your actual implementation
    return Scaffold(
      appBar: AppBar(title: Text('STT')),
      body: Center(child: Text('STT Page')),
>>>>>>> Stashed changes
    );
  }
}
