import 'package:firebase_database/firebase_database.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('uid');

class userInfo {
  cekuid() async {
    final uid = storage.getItem('uid');
    DatabaseReference coba = FirebaseDatabase.instance.ref();
    final data = await coba.child('/pelanggan/bottlecash/$uid').get();
    //print(data.value);
    return data.value;
    // print(storage.getItem('uid'));
    //await ref.set({'name': '2000'});
    // final cek = await ref.child('pelanggan/bottlecash').get();
    // if (cek.exists) {
    //   print(cek.value);
    // } else {
    //   print('No data available.');
    // }
    // print(cek.value);
  }
}
