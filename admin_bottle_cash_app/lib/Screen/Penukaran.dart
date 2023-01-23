import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  @override
  void initstate() {
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('pelanggan/bottlecash');
  }

  Widget listItem({required Map pelanggan}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 120,
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
            pelanggan['koin'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _showMyDialog(pelanggan);
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
                  _showMyDialog2(pelanggan);
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
      body: Container(),
    );
  }

  Future<void> _showMyDialog(pelanggan) async {
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
                    reference
                        .child(pelanggan['key'])
                        .update({'koin': _koinbaru.text});
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

  Future<void> _showMyDialog2(pelanggan) async {
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
