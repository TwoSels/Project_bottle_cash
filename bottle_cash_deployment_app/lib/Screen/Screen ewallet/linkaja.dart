import 'package:bottle_cash_deployment_app/Notifikasi/notifikasi.dart';
import 'package:bottle_cash_deployment_app/Service_auth/currentuserinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class linkaja extends StatefulWidget {
  linkaja({Key? key}) : super(key: key);

  @override
  State<linkaja> createState() => _linkajaState();
}

class _linkajaState extends State<linkaja> {
  final _formKey = GlobalKey<FormState>();
  final String huruf = "[a-z],[A-Z]";
  final database = FirebaseDatabase.instance.ref();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference saldo = FirebaseDatabase.instance.ref();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController bcash = TextEditingController();

  TextEditingController nomor = TextEditingController();

  var saldouser;
  var ceksaldo;

  @override
  void initState() {
    super.initState();
    requestpermission();
    getprofil();
    if (mounted) setState(() {});
  }

  void _incrementCounter() {
    if (mounted)
      setState(() {
        callOnFcmApiSendPushNotifications(
            title: 'Penukaran Saldo LinkAja',
            body: 'Segera Lihat Halaman Penukaran ya');
      });
  }

  // void dispose() {
  //   bcash.dispose();
  //   nomor.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final tukar = database.child('pelanggan/bottlecash/$uid/');
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Color(0xFFCCD640),
          elevation: 5,
          title: Text(
            'Penukaran LinkAja',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 600,
                  width: 330,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black),
                  // ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'Nomor LinkAja',
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700))),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          controller: nomor,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 1.5),
                                  borderRadius: BorderRadius.circular(7)),
                              hintText: '08xxxxxxxxxx'),
                          validator: (value) {
                            if (value == null ||
                                value.length < 11 ||
                                value == huruf) {
                              return 'Masukkan Nomor';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Input Nominal B-Cash',
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700))),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: false,
                          controller: bcash,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(CupertinoIcons.money_rubl_circle_fill),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 1.5),
                                  borderRadius: BorderRadius.circular(7)),
                              hintText: '10.000'),
                          validator: (value) {
                            if (value == null ||
                                value.length < 5 ||
                                value == huruf) {
                              return 'Masukkan nominal yang ingin ditukar';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 45,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () async {
                                var saldo = bcash.text;
                                var jumlahtransaksi = int.parse(saldo);
                                ceksaldo = int.parse(saldouser);
                                if (_formKey.currentState!.validate()) {
                                  if (ceksaldo < jumlahtransaksi) {
                                    Fluttertoast.showToast(
                                        msg: 'Saldo kamu kurang');
                                  } else {
                                    ceksaldo -= jumlahtransaksi;
                                    notifikasi_tampil().notifikasiTampil(
                                        title: 'Penukaran Sedang Berlangsung',
                                        body: 'mohon ditunggu');
                                    Fluttertoast.showToast(
                                        msg: 'traksansi berhasil dilakukan');
                                    _incrementCounter();
                                    await tukar.update({
                                      'tukar': '$saldo penukaran Saldo LinkAja'
                                    });
                                    await tukar
                                        .child('history penukaran')
                                        .push()
                                        .set({
                                      'tukar': '$saldo penukaran Saldo LinkAja'
                                    });
                                    await tukar
                                        .child('transaksi ewallet')
                                        .push()
                                        .set({
                                      'ewallet': 'LinkAja',
                                      'nomor': nomor.text,
                                      'transaksi': saldo,
                                    });
                                    Navigator.pop(context);
                                  }
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
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

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

  void saldomemenuhi(int jumlahtransaksi) async {
    final tukar = database.child('pelanggan/bottlecash/$uid/');
    ceksaldo = int.parse(saldouser);
    if (ceksaldo < jumlahtransaksi) {
      Fluttertoast.showToast(msg: 'saldo tak cukup');
    } else {
      ceksaldo -= jumlahtransaksi;
      notifikasi_tampil().notifikasiTampil(
          title: 'Penukaran Sedang Berlangsung', body: 'mohon ditunggu');
      Fluttertoast.showToast(msg: 'traksansi berhasil dilakukan');
      //_incrementCounter();
      //await tukar.update({'tukar': '$saldo penukaran tagihan indihome'});
      await tukar.child('transaksi ewallet').set({
        'nomor': nomor.text,
        'transaksi': saldo,
      });
      Navigator.pop(context);
    }
  }
}
