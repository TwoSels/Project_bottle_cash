import 'package:bottle_cash_deployment_app/Screen/LoginPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class editemail extends StatefulWidget {
  editemail({Key? key}) : super(key: key);

  @override
  State<editemail> createState() => _editemailState();
}

class _editemailState extends State<editemail> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;
  String cekUid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference profil = FirebaseDatabase.instance.ref();

  var email;

  // void dispose() {
  //   _emailController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    getnama();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Ubah Email',
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
                              controller: _emailController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                labelText: 'Email',
                                hintText: '$email',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              //validasi untuk email
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Masukkan Email'
                                  : null,
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
                              updateEmail();
                              profil
                                  .child('pelanggan/bottlecash/$cekUid/')
                                  .update({
                                'email': _emailController.text,
                              });
                              Fluttertoast.showToast(
                                  msg: 'Email baru berhasil tersimpan');
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

  void updateEmail() async {
    try {
      await user!.updateEmail(_emailController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      Fluttertoast.showToast(msg: 'Berhasil Update Email');
    } catch (e) {
      print('gagal');
    }
  }

  void getnama() {
    profil.child('/pelanggan/bottlecash/$cekUid/').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map profiluser = event.snapshot.value as Map;
      profiluser.forEach((key, value) {
        if (mounted)
          setState(() {
            email = profiluser['email'];
          });
      });
    });
  }
}
