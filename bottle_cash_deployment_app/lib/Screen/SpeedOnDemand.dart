import 'package:bottle_cash_deployment_app/Service_auth/currentuserinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  //deklarasi variable global
  final database = FirebaseDatabase.instance.ref();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference saldo = FirebaseDatabase.instance.ref();
  //deklarasi untuk groupvalue
  int? paketSOD;
  //deklarasi untuk harga
  int paket1day30mbps = 40000;
  int paket1day40mbps = 74000;
  int paket7day30mbps = 260000;
  //variable untuk dimasukkan data dari database
  var saldouser;
  var ceksaldo;
  //fungsi agar state berjalan otomatis
  @override
  void initState() {
    getprofil();
    if (mounted) setState(() {});
    super.initState();
  }

  //fungsi push notification ke aplikasi admin
  void _incrementCounter() {
    setState(() {
      callOnFcmApiSendPushNotifications(
          title: 'Penukaran Speed On Demand',
          body: 'Segera Lihat Halaman Penukaran ya');
    });
  }

  //widget utama
  @override
  Widget build(BuildContext context) {
    //deklarasi child database
    final tukar = database.child('pelanggan/bottlecash/$uid/');
    return Scaffold(
        //appbar
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
                    //tittle
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
                        //radio button pilihan 1
                        Radio(
                            value: paket1day30mbps,
                            groupValue: paketSOD,
                            onChanged: ((value) {
                              setState(() {
                                paketSOD = value;
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
                        //radio button pilihan 2
                        Radio(
                            value: paket1day40mbps,
                            groupValue: paketSOD,
                            onChanged: ((value) {
                              setState(() {
                                paketSOD = value;
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
                        //radio button pilihan 3
                        Radio(
                            value: paket7day30mbps,
                            groupValue: paketSOD,
                            onChanged: ((value) {
                              setState(() {
                                paketSOD = value;
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
                    //button untuk tukarbcash
                    SizedBox(
                      height: 45,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          var jumlahtransaksi;
                          ceksaldo = int.parse(saldouser);
                          jumlahtransaksi = paketSOD;
                          //pengecekan kondisi saldo memenuhhi dan tidak terpenuhi
                          if (ceksaldo < paketSOD) {
                            Fluttertoast.showToast(msg: 'Saldo kamu kurang');
                          } else {
                            ceksaldo -= paketSOD;
                            _incrementCounter();
                            notifikasi_tampil().notifikasiTampil(
                                title: 'Penukaran Sedang Berlangsung',
                                body: 'mohon ditunggu');
                            Fluttertoast.showToast(msg: 'Transaksi Berhasil');
                            await tukar.update({
                              'tukar': 'Paket ' +
                                  paketSOD.toString() +
                                  ' Speed On Demand'
                            });
                            await tukar.child('history penukaran').push().set({
                              'tukar': 'Paket ' +
                                  paketSOD.toString() +
                                  ' Speed On Demand'
                            });
                            await tukar.child('transaksi SOD').push().set({
                              'transaksi': 'Paket ' +
                                  paketSOD.toString() +
                                  ' Speed On Demand'
                            });
                            Navigator.pop(context);
                          }
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

  //fungsi untuk mengambil data saldo dari databse
  void getprofil() {
    saldo.child('/pelanggan/bottlecash/$uid/').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map profiluser = event.snapshot.value as Map;
      profiluser.forEach((key, value) {
        if (mounted)
          setState(() {
            saldouser = profiluser['saldo'];
          });
      });
    });
  }
}
