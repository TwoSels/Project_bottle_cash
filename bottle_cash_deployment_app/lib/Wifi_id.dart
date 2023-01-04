import 'package:flutter/material.dart';

class Wifi_id extends StatefulWidget {
  Wifi_id({Key? key}) : super(key: key);

  @override
  State<Wifi_id> createState() => _Wifi_idState();
}

class _Wifi_idState extends State<Wifi_id> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        title: Text('Wifi ID'),
      ),
    );
  }
}
