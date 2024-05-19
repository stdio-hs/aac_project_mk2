import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class DataLoader extends ChangeNotifier {
  Map<String, dynamic>? data;

  DataLoader() {
    _loadData();
  }

  Future<void> _loadData() async {
    final jsonString = await rootBundle.loadString('assets/aac_data.json');
    data = jsonDecode(jsonString);
    notifyListeners();
  }

  List<dynamic> getNodesById(List<int> nodeIds) {
    if (data == null) return [];
    return nodeIds.map((id) => data!['AAC'].firstWhere((node) => node['id'] == id, orElse: () => null)).where((node) => node != null).toList();
  }
}
