import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class history extends StatefulWidget {
  history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  Query transaksi = FirebaseDatabase.instance
      .ref()
      .child('pelanggan/bottlecash/history penukaran/');
  String uid = FirebaseAuth.instance.toString();
  DatabaseReference cekuser = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FirebaseAnimatedList(
        query: transaksi,
        itemBuilder: ((context, snapshot, animation, index) {
          Map hslpenukaran = snapshot.value as Map;
          hslpenukaran['key'] = snapshot.key;

          return Container(
            height: 300,
            child: Column(
              children: [Text(hslpenukaran['tukar'])],
            ),
          );
        }),
      ),
    );
  }
}
