import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_loader.dart';
import 'common_widgets.dart';
import 'tree_final.dart';

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
        return GestureDetector(
          onTap: () {
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
          },
          child: NodeCard(node: node),
        );
      },
    );
  }
}

class NodeCard extends StatelessWidget {
  final dynamic node;

  NodeCard({required this.node});

  @override
  Widget build(BuildContext context) {
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
            Icon(Icons.folder, size: 50, color: Colors.blue), // Placeholder icon
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
