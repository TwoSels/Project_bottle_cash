import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class historytransaksi extends StatefulWidget {
  historytransaksi({Key? key}) : super(key: key);

  @override
  State<historytransaksi> createState() => _historytransaksiState();
}

class _historytransaksiState extends State<historytransaksi> {
  String cekUid = FirebaseAuth.instance.currentUser!.uid;

  Widget listItem1({required Map pelanggan}) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              //offset: Offset(4, 4),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset('Asset/icon_logo.png'),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penukaran',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Jenis Transaksi',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Nomor IndiHome: ' + pelanggan['nomor'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Transaki sebesar Rp.' + pelanggan['transaksi'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  Widget listItem2({required Map pelanggan}) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              //offset: Offset(4, 4),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset('Asset/icon_logo.png'),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penukaran',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Jenis Transaksi',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Penukaran ' + pelanggan['transaksi'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  Widget listItem3({required Map pelanggan}) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              //offset: Offset(4, 4),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset('Asset/icon_logo.png'),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penukaran ' + pelanggan['ewallet'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Jenis Transaksi',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Nomor ' +
                          pelanggan['ewallet'] +
                          ': ' +
                          pelanggan['nomor'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Penukaran ' + pelanggan['transaksi'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    ScrollController reverseController;
    //final bool reverse = true;
    final Axis scrollDirection;
    Query indihome = FirebaseDatabase.instance
        .ref()
        .child('pelanggan/bottlecash/$cekUid/transaksi indihome/');
    Query wifi_id = FirebaseDatabase.instance
        .ref()
        .child('pelanggan/bottlecash/$cekUid/transaksi wifiID/');
    Query SOD = FirebaseDatabase.instance
        .ref()
        .child('pelanggan/bottlecash/$cekUid/transaksi SOD/');
    Query ewallet = FirebaseDatabase.instance
        .ref()
        .child('pelanggan/bottlecash/$cekUid/transaksi ewallet/');
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFCCD640),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Indihome',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Wifi.ID',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Speed On Demand',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'E-Wallet',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            title: Center(
              child: Text('Transaksi',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
            )),
        body: TabBarView(
          children: [
            FirebaseAnimatedList(
                reverse: false,
                query: indihome,
                itemBuilder: ((context, snapshot, animation, index) {
                  Map pelanggan = snapshot.value as Map;
                  pelanggan['key'] = snapshot.key;
                  return listItem1(pelanggan: pelanggan);
                })),
            FirebaseAnimatedList(
                reverse: false,
                query: wifi_id,
                itemBuilder: ((context, snapshot, animation, index) {
                  Map pelanggan = snapshot.value as Map;
                  pelanggan['key'] = snapshot.key;
                  return listItem2(pelanggan: pelanggan);
                })),
            FirebaseAnimatedList(
                reverse: false,
                query: SOD,
                itemBuilder: ((context, snapshot, animation, index) {
                  Map pelanggan = snapshot.value as Map;
                  pelanggan['key'] = snapshot.key;
                  return listItem2(pelanggan: pelanggan);
                })),
            FirebaseAnimatedList(
                reverse: false,
                query: ewallet,
                itemBuilder: ((context, snapshot, animation, index) {
                  Map pelanggan = snapshot.value as Map;
                  pelanggan['key'] = snapshot.key;
                  return listItem3(pelanggan: pelanggan);
                })),
          ],
        ),
      ),
    );
  }
}
