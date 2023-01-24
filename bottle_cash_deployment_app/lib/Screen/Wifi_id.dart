import 'package:bottle_cash_deployment_app/Service_auth/currentuserinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Notifikasi/notifikasi.dart';

class Wifi_id extends StatefulWidget {
  Wifi_id({Key? key}) : super(key: key);

  @override
  State<Wifi_id> createState() => _Wifi_idState();
}

class _Wifi_idState extends State<Wifi_id> {
  final database = FirebaseDatabase.instance.ref();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var pilihan1;
  @override
  String? paketWifi_id;
  void initstate() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      callOnFcmApiSendPushNotifications(
          title: 'Penukaran Wifi.Id',
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
            'Wifi.id Seamless',
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
                            text: 'Paket Harga Voucher @wifi.id',
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    Row(
                      children: [
                        SizedBox(
                          width: 45,
                        ),
                        Radio(
                            value: 'Paket 12 Jam @wifi.id',
                            groupValue: paketWifi_id,
                            onChanged: ((value) {
                              setState(() {
                                paketWifi_id = value.toString();
                              });
                            })),
                        Text(
                          'Paket 12 Jam Rp. 5.000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 45,
                        ),
                        Radio(
                            value: 'Paket 7 hari @wifi.id',
                            groupValue: paketWifi_id,
                            onChanged: ((value) {
                              setState(() {
                                paketWifi_id = value.toString();
                              });
                            })),
                        Text(
                          'Paket 7 Hari Rp. 20.000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 45,
                        ),
                        Radio(
                            value: 'Paket 30 Hari @wifi.id',
                            groupValue: paketWifi_id,
                            onChanged: ((value) {
                              setState(() {
                                paketWifi_id = value.toString();
                              });
                            })),
                        Text(
                          'Paket 30 Jam Rp. 50.000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                          await tukar.update({'tukar': paketWifi_id});
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
