import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class nomorindihone extends StatefulWidget {
  nomorindihone({Key? key}) : super(key: key);

  @override
  State<nomorindihone> createState() => _nomorindihoneState();
}

class _nomorindihoneState extends State<nomorindihone> {
  String cekUid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference profil = FirebaseDatabase.instance.ref();
  TextEditingController _phoneController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var nomorindihome;

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
        backgroundColor: Color(0xFFCCD640),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Indihome',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
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
                      Text(
                        'Masukkan Nomor IndiHome',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            TextFormField(
                              obscureText: false,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: 'Nomor Indihome',
                                hintText: '$nomorindihome',
                              ),
                              validator: (value) {
                                if (value == null || value.length < 10) {
                                  return 'Masukkan Nomor IndiHome Kamu';
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
                              profil
                                  .child('pelanggan/bottlecash/$cekUid/')
                                  .update({
                                'nomor indihome': _phoneController.text,
                              });
                              Fluttertoast.showToast(
                                  msg: 'Nomor indiHome berhasil tersimpan');
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

  void getprofil() {
    profil.child('/pelanggan/bottlecash/$cekUid/').onValue.listen((event) {
      //print(event.snapshot.value.toString());
      Map profiluser = event.snapshot.value as Map;
      profiluser.forEach((key, value) {
        if (mounted)
          setState(() {
            nomorindihome = profiluser['nomor indihome'];
          });
      });
    });
  }
}
