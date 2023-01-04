import 'package:flutter/material.dart';

class SODPage extends StatefulWidget {
  SODPage({Key? key}) : super(key: key);

  @override
  State<SODPage> createState() => _SODPageState();
}

class _SODPageState extends State<SODPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        title: Text('Speed On Demand'),
      ),
    );
  }
}
