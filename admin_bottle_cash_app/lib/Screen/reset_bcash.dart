import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class reset_bcash extends StatefulWidget {
  reset_bcash({Key? key}) : super(key: key);
  @override
  State<reset_bcash> createState() => _reset_bcashState();
}

class _reset_bcashState extends State<reset_bcash> {
  Query dbref = FirebaseDatabase.instance.ref('pelanggan/bottlecash');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('pelanggan/bottlecash');
  //late DatabaseReference ref;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference _dbref =
      FirebaseDatabase.instance.ref('pelanggan/bottlecash');
  String databasejson = '';

  @override
  void initstate() {
    super.initState();
    //dbref = FirebaseDatabase.instance.ref().child('pelanggan/bottlecash/$uid');
  }

  // void getPelanggaData() async {
  //   DataSnapshot snapshot = (await ref.child(dbref).once()) as DataSnapshot;
  // }
  @override
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
            pelanggan['saldo'],
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
        title: Text('Reset B-Cash'),
      ),
      body:
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       StreamBuilder(
          //           stream: _dbref.onValue,
          //           builder: (context, AsyncSnapshot snapshot) {
          //             if (snapshot.hasData &&
          //                 !snapshot.hasError &&
          //                 snapshot.data.snapshot.value != null) {
          //               Map data = snapshot.data.snapshot.value;
          //               List item = [];
          //               data.forEach(
          //                   (index, data) => item.add({"key": index, ...data}));
          //               return Expanded(
          //                   child: ListView.builder(
          //                       itemCount: item.length,
          //                       itemBuilder: ((context, index) {
          //                         return ListTile(
          //                           leading: GestureDetector(
          //                             onTap: () {},
          //                             child: Icon(Icons.edit_attributes_rounded),
          //                           ),
          //                           trailing: GestureDetector(
          //                             onTap: () {},
          //                             child: Icon(Icons.delete),
          //                           ),
          //                           title: Text(
          //                               "UID pelanggan: ${item[index]['key']}"),
          //                           subtitle: Text(
          //                               'nama: ${item[index]['nama'].toString()} \nemail: ${item[index]['email']}\nsaldo: ${item[index]['saldo']}'),
          //                           isThreeLine: true,
          //                         );
          //                       })));
          //             } else {
          //               return Center(
          //                 child: Text('no data'),
          //               );
          //             }
          //           })
          //     ],
          //   ),
          // )

          Container(
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
