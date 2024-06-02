import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_loader.dart';
import 'ui/home_widget.dart';
import 'package:aac_project_mk2/bloc/stt_controller.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SttController sttController = Get.put(SttController());

    return ChangeNotifierProvider(
      create: (context) => DataLoader(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeWidget(),
      ),
    );
  }
}
