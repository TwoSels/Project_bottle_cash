import 'package:flutter/material.dart';

class AchievmentPage extends StatefulWidget {
  AchievmentPage({Key? key}) : super(key: key);

  @override
  State<AchievmentPage> createState() => _AchievmentPageState();
}

class _AchievmentPageState extends State<AchievmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Ini halaman achievement")],
        ),
      ),
    );
  }
}
