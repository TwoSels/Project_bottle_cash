import 'package:bottle_cash_deployment_app/Service_auth/currentuserinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  //deklarasi variable global
  final database = FirebaseDatabase.instance.ref();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  var pilihan1;
  DatabaseReference saldo = FirebaseDatabase.instance.ref();

  //variabel untuk memasukkan data dari database
  var saldouser;
  var ceksaldo;
  var jumlah;

  //deklarasi int untuk harga setiap radio button
  int paket12jam = 5000;
  int paket7hari = 20000;
  int paket30jam = 50000;

  //deklarasi groupvalue
  String? paketWifi_id;
  int? hargawifi_id;

  //fungsi agar state berjalan otomatis
  @override
  void initState() {
    getprofil();
    if (mounted) setState(() {});
    super.initState();
  }

  //fungsi push notification untuk ke aplikasi admin
  void _incrementCounter() {
    if (mounted)
      setState(() {
        callOnFcmApiSendPushNotifications(
            title: 'Penukaran Wifi.Id',
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
            //isi container
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
                        //radio button pilihan 1
                        Radio(
                            value: paket12jam,
                            groupValue: hargawifi_id,
                            onChanged: ((value) {
                              if (mounted)
                                setState(() {
                                  hargawifi_id = value;
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
                        //radio button pilihan 2
                        Radio(
                            value: paket7hari,
                            groupValue: hargawifi_id,
                            onChanged: ((value) {
                              if (mounted)
                                setState(() {
                                  hargawifi_id = value;
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
                        //radio button pilihan 3
                        Radio(
                            value: paket30jam,
                            groupValue: hargawifi_id,
                            onChanged: ((value) {
                              if (mounted)
                                setState(() {
                                  hargawifi_id = value;
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
                    //button penukaran
                    SizedBox(
                      height: 45,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          var jumlahtransaksi;
                          //fungsi parsing string ke int
                          ceksaldo = int.parse(saldouser);
                          //memasukkan isi hargawifi_id ke dalam var diatas
                          jumlahtransaksi = hargawifi_id;
                          //fungsi cek saldo ketika cukup dan tidak cukup
                          if (ceksaldo < hargawifi_id) {
                            Fluttertoast.showToast(msg: 'Saldo kamu kurang');
                          } else {
                            ceksaldo -= hargawifi_id;
                            //_incrementCounter();
                            notifikasi_tampil().notifikasiTampil(
                                title: 'Penukaran Sedang Berlangsung',
                                body: 'mohon ditunggu');
                            Fluttertoast.showToast(msg: 'Transaksi Berhasil');
                            await tukar.update({
                              'tukar': 'Paket ' +
                                  hargawifi_id.toString() +
                                  ' Wifi ID'
                            });
                            await tukar.child('history penukaran').push().set({
                              'tukar': 'Paket ' +
                                  hargawifi_id.toString() +
                                  ' Wifi ID'
                            });
                            await tukar.child('transaksi wifiID').push().set({
                              'transaksi': 'Paket ' +
                                  hargawifi_id.toString() +
                                  ' Wifi ID'
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

  //fungsi mendapatkan isi saldo dari database
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

  //fungsi untuk saldo ketika terpenuhi
  void saldomemenuhi(int jumlahtransaksi) {
    ceksaldo = int.parse(saldouser);
    if (ceksaldo < jumlahtransaksi) {
      Fluttertoast.showToast(msg: 'saldo tak cukup');
    } else {
      ceksaldo -= jumlahtransaksi;
      notifikasi_tampil().notifikasiTampil(
          title: 'Penukaran Sedang Berlangsung', body: 'mohon ditunggu');
      Fluttertoast.showToast(msg: 'traksansi berhasil dilakukan');
    }
  }
}
