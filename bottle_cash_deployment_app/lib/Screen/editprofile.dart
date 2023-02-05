import 'package:bottle_cash_deployment_app/Screen/editemail.dart';

import 'package:bottle_cash_deployment_app/Screen/editnama.dart';
import 'package:bottle_cash_deployment_app/Screen/editnohp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class editprofil extends StatefulWidget {
  editprofil({Key? key}) : super(key: key);

  @override
  State<editprofil> createState() => _editprofilState();
}

class _editprofilState extends State<editprofil> {
  String cekUid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference profil = FirebaseDatabase.instance.ref();
  final ImagePicker _picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? photo;

  var nama;
  var emailuser;
  var nohpuser;
  var imageurl;

  Future ambilfoto(BuildContext context) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (mounted)
      setState(() {
        if (pickedFile != null) {
          photo = File(pickedFile.path);
          uploadimage(context);
        } else {
          print('gagal');
        }
      });
  }

  Future galeri(BuildContext context) async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (mounted)
      setState(() {
        if (pickedFile != null) {
          photo = File(pickedFile.path);
          uploadimage(context);
        } else {
          print('gagal');
        }
      });
  }

  void uploadimage(BuildContext context) async {
    if (photo == null) return;
    final filename = basename(photo!.path);
    final destination = 'images/$cekUid/$filename';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(photo!);
      String newurl = await ref.getDownloadURL();
      await profil
          .child('pelanggan/bottlecash/$cekUid/')
          .update({'profilURL': newurl});
      Fluttertoast.showToast(msg: 'Foto Profil Kamu Barusan Diupdate');
    } catch (e) {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    getprofil();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Akun saya',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Color(0xFFCCD640),
      ),
      body: Container(
          child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage('$imageurl'),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.green,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'Ubah Foto Profil',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 40,
                              width: 150,
                              child: ElevatedButton(
                                child: Row(
                                  children: [
                                    Icon(Icons.image),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Pilih Foto')
                                  ],
                                ),
                                onPressed: () {
                                  galeri(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 40,
                              width: 150,
                              child: ElevatedButton(
                                child: Row(
                                  children: [
                                    Icon(Icons.photo_camera),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Ambil Foto')
                                  ],
                                ),
                                onPressed: () {
                                  ambilfoto(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Ubah Foto Profil',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 160,
              width: 370,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Info Profil',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Nama ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 39,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => editnama()));
                        },
                        child: Row(
                          children: [
                            Text(
                              '$nama',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 46,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => editemail()));
                        },
                        child: Row(
                          children: [
                            Text(
                              '$emailuser',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Nomor HP',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => editnohp()));
                        },
                        child: Row(
                          children: [
                            Text(
                              '$nohpuser',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 116,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void getprofil() {
    profil.child('/pelanggan/bottlecash/$cekUid/').onValue.listen((event) {
      //print(event.snapshot.value.toString());
      Map profiluser = event.snapshot.value as Map;
      profiluser.forEach((key, value) {
        if (mounted)
          setState(() {
            nama = profiluser['nama'];
            emailuser = profiluser['email'];
            nohpuser = profiluser['nohp'];
            imageurl = profiluser['profilURL'];
          });
      });
    });
  }
}
