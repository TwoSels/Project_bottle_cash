import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class reset_gembok extends StatefulWidget {
  reset_gembok({Key? key}) : super(key: key);

  @override
  State<reset_gembok> createState() => _reset_gembokState();
}

class _reset_gembokState extends State<reset_gembok> {
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('kode');
  final TextEditingController update = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Update Kode Gembok'),
      ),
      body: Container(
        child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 400,
              width: 330,
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: 280,
                    child: Image.asset("asset/Aset Page 1.png"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: update,
                      decoration: InputDecoration(
                          hintText: 'Masukkan kode baru',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                        onPressed: () {
                          reference
                              .set({'gembok': update.text.toString().trim()});
                          Fluttertoast.showToast(msg: "kode berhasil diupdate");
                          Navigator.pop(context);
                        },
                        child: Text('Update Kode')),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
