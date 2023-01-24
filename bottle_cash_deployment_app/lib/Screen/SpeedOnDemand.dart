import 'package:bottle_cash_deployment_app/Service_auth/currentuserinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Notifikasi/notifikasi.dart';

class SODPage extends StatefulWidget {
  SODPage({Key? key}) : super(key: key);

  @override
  State<SODPage> createState() => _SODPageState();
}

class _SODPageState extends State<SODPage> {
  String? paketSOD;
  final database = FirebaseDatabase.instance.ref();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initstate() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      callOnFcmApiSendPushNotifications(
          title: 'Penukaran Speed On Demand',
          body: 'Segera Lihat Halaman Penukaran ya');
    });
  }

  @override
  Widget build(BuildContext context) {
    final tukar = database.child('pelanggan/bottlecash/$uid/');
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Color(0xFFCCD640),
          elevation: 5,
          title: Text(
            'Speed On Demand',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 590,
                width: 330,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black),
                // ),
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Paket Harga Speed On Demand',
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Radio(
                            value: '1 Day Boost 30Mbps Speed On Demand',
                            groupValue: paketSOD,
                            onChanged: ((value) {
                              setState(() {
                                paketSOD = value.toString();
                              });
                            })),
                        Text(
                          '1 Day Boost 30Mbps Rp. 40.000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Radio(
                            value: '1 Day Boost 40Mbps',
                            groupValue: paketSOD,
                            onChanged: ((value) {
                              setState(() {
                                paketSOD = value.toString();
                              });
                            })),
                        Text(
                          '1 Day Boost 40Mbps Rp. 74.000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Radio(
                            value: '7 Day Boost 40Mbps',
                            groupValue: paketSOD,
                            onChanged: ((value) {
                              setState(() {
                                paketSOD = value.toString();
                              });
                            })),
                        Text(
                          '7 Day Boost 30Mbps Rp. 260.000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          _incrementCounter();
                          notifikasi_tampil().notifikasiTampil(
                              title: 'Penukaran Sedang Berlangsung',
                              body: 'mohon ditunggu');
                          await tukar.update({'tukar': paketSOD});
                          Navigator.pop(context);
                        },
                        child: const Text('Tukar B-Cash'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset("Asset/gambarlogo.png"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
