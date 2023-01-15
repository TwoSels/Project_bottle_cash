import 'package:flutter/material.dart';

class reset_bcash extends StatefulWidget {
  reset_bcash({Key? key}) : super(key: key);

  @override
  State<reset_bcash> createState() => _reset_bcashState();
}

class _reset_bcashState extends State<reset_bcash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Reset B-Cash'),
      ),
      body: Container(),
    );
  }
}
