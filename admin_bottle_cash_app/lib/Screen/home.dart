import 'package:admin_bottle_cash_app/Screen/Penukaran.dart';
import 'package:admin_bottle_cash_app/Screen/login_page.dart';
import 'package:admin_bottle_cash_app/Screen/penyimpanan.dart';
import 'package:admin_bottle_cash_app/Screen/reset_bcash.dart';
import 'package:admin_bottle_cash_app/Screen/reset_kodegembok.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('kode');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 600,
              width: 350,
              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: 280,
                    child: Image.asset("asset/Aset Page 1.png"),
                  ),
                  Text(
                    "Kode Gembok",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    child: FirebaseAnimatedList(
                      query: reference,
                      itemBuilder: (context, snapshot, animation, index) {
                        return Text(
                          snapshot.child('gembok').value.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => penukaran()));
                      },
                      child: Text('Permintaan Penukaran'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   width: 200,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => reset_bcash()));
                  //     },
                  //     child: Text('Reset B-Cash User'),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => penyimpanan()));
                        },
                        child: Text('Penyimpanan')),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => reset_gembok()));
                      },
                      child: Text('Kode Gembok'),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await auth.signOut();
                        Fluttertoast.showToast(msg: 'Berhasil keluar');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_page()));
                      },
                      child: Text('Keluar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
