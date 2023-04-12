import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:text_scanner/views/home_screen.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
