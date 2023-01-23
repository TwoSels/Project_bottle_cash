import 'package:flutter/material.dart';

class scanqr_code extends StatefulWidget {
  scanqr_code({Key? key}) : super(key: key);

  @override
  State<scanqr_code> createState() => _scanqr_codeState();
}

class _scanqr_codeState extends State<scanqr_code> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Ini halaman scan qr")],
        ),
      ),
    );
  }
}
