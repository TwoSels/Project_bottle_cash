import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class editnohp extends StatefulWidget {
  editnohp({Key? key}) : super(key: key);

  @override
  State<editnohp> createState() => _editnohpState();
}

class _editnohpState extends State<editnohp> {
  String cekUid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference profil = FirebaseDatabase.instance.ref();
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // void dispose() {
  //   _phoneController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Ubah Nomor HP',
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
                              controller: _phoneController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: 'No. HP',
                                hintText: '08xxxxxxxxxx',
                              ),
                              validator: (value) {
                                if (value == null || value.length < 11) {
                                  return 'Masukkan Nomor HP Anda';
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
                                'nohp': _phoneController.text,
                              });
                              Fluttertoast.showToast(
                                  msg: 'Nomor baru berhasil tersimpan');
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
}
