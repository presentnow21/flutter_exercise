import './src/controller/root_controller.dart';
import 'package:flutter/material.dart';
import './src/root.dart';
import 'package:get/get.dart';
import './src/pages/home/detail.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(RootController());
      }),
      home: Root(),
      getPages: [GetPage(name: '/detailPage', page: () => const Detail())],
    );
  }
}
