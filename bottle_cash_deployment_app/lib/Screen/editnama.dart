import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class editnama extends StatefulWidget {
  editnama({Key? key}) : super(key: key);

  @override
  State<editnama> createState() => _editnamaState();
}

class _editnamaState extends State<editnama> {
  String cekUid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference profil = FirebaseDatabase.instance.ref();
  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String spasi = " ";
  bool didDispose = false;

  var nama;

  // void dispose() {
  //   _nameController.dispose();
  //   super.dispose();
  // }

  void safeSetState(VoidCallback callback) {
    if (!didDispose) {
      setState(callback);
    }
  }

  @override
  void initState() {
    super.initState();
    getnama();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Ubah Nama',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Align(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 450,
                  width: 300,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              obscureText: false,
                              controller: _nameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: 'Ubah Nama',
                                hintText: '$nama',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan nama';
                                } else if (value == spasi) {
                                  return null;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 45,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              getnama();
                              profil
                                  .child('pelanggan/bottlecash/$cekUid/')
                                  .update({
                                'nama': _nameController.text,
                              });
                              Fluttertoast.showToast(
                                  msg: 'Nama berhasil tersimpan');
                              Navigator.pop(context);
                            }
                            // final isValidForm =
                            //     _formKey.currentState?.validate();

                            // if (isValidForm){

                            // }
                          },
                          child: const Text('SIMPAN'),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF8DC13F),
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void getnama() {
    profil.child('/pelanggan/bottlecash/$cekUid/').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map profiluser = event.snapshot.value as Map;
      profiluser.forEach((key, value) {
        setState(() {
          nama = profiluser['nama'];
        });
      });
    });
  }
}
