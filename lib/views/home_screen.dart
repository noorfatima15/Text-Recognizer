import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Scan Text')),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const Text('click on the button above to scan text'),
        ],
      ),
    )));
  }
}
