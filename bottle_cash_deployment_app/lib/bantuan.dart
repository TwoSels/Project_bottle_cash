import 'package:flutter/material.dart';

class halaman_bantuan extends StatefulWidget {
  halaman_bantuan({Key? key}) : super(key: key);

  @override
  State<halaman_bantuan> createState() => _halaman_bantuanState();
}

class _halaman_bantuanState extends State<halaman_bantuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text("Ini halaman bantuan")],
        ),
      ),
    );
  }
}
