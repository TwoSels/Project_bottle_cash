import 'package:flutter/material.dart';

class reset_gembok extends StatefulWidget {
  reset_gembok({Key? key}) : super(key: key);

  @override
  State<reset_gembok> createState() => _reset_gembokState();
}

class _reset_gembokState extends State<reset_gembok> {
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
              height: 390,
              width: 330,
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Container(
                    height: 240,
                    width: 280,
                    child: Image.asset("asset/Aset Page 1.png"),
                  ),
                  TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        label: Text("Reset Kode Gembok"),
                        hintText: 'Masukkan kode baru'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Update Kode')),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
