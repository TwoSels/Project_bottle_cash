import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class penyimpanan extends StatefulWidget {
  penyimpanan({Key? key}) : super(key: key);

  @override
  State<penyimpanan> createState() => _penyimpananState();
}

class _penyimpananState extends State<penyimpanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Penyimpanan'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Jumlah Botol Sekarang',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '%hslbotol%',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Jumlah Tutup Sekarang',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '%hsltutu%',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
