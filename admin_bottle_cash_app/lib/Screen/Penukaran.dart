import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../authservice/notifikasiservice.dart';

class penukaran extends StatefulWidget {
  penukaran({Key? key}) : super(key: key);

  @override
  State<penukaran> createState() => _penukaranState();
}

class _penukaranState extends State<penukaran> {
  Query dbref = FirebaseDatabase.instance.ref().child('pelanggan/bottlecash');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('pelanggan/bottlecash');
  late DatabaseReference ref;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initstate() {
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('pelanggan/bottlecash/$uid');
  }

  void _incrementCounter() {
    setState(() {
      callOnFcmApiSendPushNotifications(
          title: 'Penukaran Berhasil',
          body: 'Terimakasih Telah memakai Bottle Cash');
    });
  }

  Widget listItem({required Map pelanggan}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      color: Colors.amberAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pelanggan['nama'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            pelanggan['email'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            pelanggan['nohp'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Text(
            pelanggan['saldo'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Text(
            pelanggan['tukar'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _resetsaldo(pelanggan);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.currency_exchange_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () {
                  _resetpenukaran(pelanggan);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: () {
                  _hapuspelanggan(pelanggan);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Data User Penukaran'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map pelanggan = snapshot.value as Map;
            pelanggan['key'] = snapshot.key;

            return listItem(pelanggan: pelanggan);
          },
        ),
      ),
    );
  }

  Future<void> _resetsaldo(pelanggan) async {
    final TextEditingController _koinbaru = new TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Masukkan koin terbaru'),
                TextField(
                  controller: _koinbaru,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Input Koin', hintText: 'Update token user'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Reset'),
                  onPressed: () {
                    _incrementCounter();
                    reference
                        .child(pelanggan['key'])
                        .update({'saldo': _koinbaru.text});
                    Fluttertoast.showToast(msg: 'Berhasil di update');
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Tutup'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetpenukaran(pelanggan) async {
    final TextEditingController _koinbaru = new TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Reset Penukaran?'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Ya'),
                  onPressed: () {
                    reference
                        .child(pelanggan['key'])
                        .update({'tukar': 'kosong'});
                    Fluttertoast.showToast(msg: 'Berhasil di update');
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Tutup'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _hapuspelanggan(pelanggan) async {
    final TextEditingController _koinbaru = new TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Ingin menghapus akun ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Ya'),
                  onPressed: () {
                    reference.child(pelanggan['key']).remove();
                    Fluttertoast.showToast(msg: 'Akun berhasil dihapus');
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Tidak'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
