// 트리구조 파트

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_loader.dart'; // 올바른 경로로 변경

class TreeView extends StatelessWidget {
  final int initialNodeId;
  final List<String> selectedNodes;
  final List<int> initialNodes;

  TreeView({required this.initialNodeId, required this.selectedNodes, required this.initialNodes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AAC Tree'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: NodeSearchDelegate());
            },
          ),
        ],
      ),
      body: Consumer<DataLoader>(
        builder: (context, dataLoader, child) {
          if (dataLoader.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return NodeList(
            nodes: dataLoader.getNodesById(initialNodes),
            selectedNodes: selectedNodes,
          );
        },
      ),
    );
  }
}

class NodeSearchDelegate extends SearchDelegate<dynamic> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var dataLoader = Provider.of<DataLoader>(context, listen: false);
    var results = dataLoader.data!['AAC']
        .where((node) => node['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return NodeList(nodes: results, selectedNodes: []);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var dataLoader = Provider.of<DataLoader>(context, listen: false);
    var suggestions = dataLoader.data!['AAC']
        .where((node) => node['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return NodeList(nodes: suggestions, selectedNodes: []);
  }
}

class NodeList extends StatelessWidget {
  final List<dynamic> nodes;
  final List<String> selectedNodes;

  NodeList({required this.nodes, required this.selectedNodes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: nodes.length,
            itemBuilder: (context, index) {
              var node = nodes[index];
              return ListTile(
                title: Text(node['name']),
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
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text((List.from(selectedNodes)..add(node['name'])).join(' ')),
                          actions: [
                            TextButton(
                              child: Text('처음으로'),
                              onPressed: () {
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
        if (selectedNodes.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              selectedNodes.join(' '),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}

class NodeDetails extends StatelessWidget {
  final int nodeId;
  final String nodeName;
  final List<dynamic> children;
  final List<String> selectedNodes;

  NodeDetails({required this.nodeId, required this.nodeName, required this.children, required this.selectedNodes});

  @override
  Widget build(BuildContext context) {
    var dataLoader = Provider.of<DataLoader>(context);
    var childNodes = dataLoader.getNodesById(children.cast<int>());

    return Scaffold(
      appBar: AppBar(
        title: Text(nodeName),
      ),
      body: NodeList(nodes: childNodes, selectedNodes: selectedNodes),
    );
  }
}
