import 'package:admin_bottle_cash_app/Screen/home.dart';
import 'package:admin_bottle_cash_app/persistent_navbar/persistent_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late bool _passwordVisible;
  final TextEditingController email = new TextEditingController();
  final TextEditingController pass = new TextEditingController();
  String spasi = " ";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Container(
        child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 240,
                    width: 280,
                    child: Image.asset("asset/Aset Page 1.png"),
                  ),
                  Container(
                      height: 245,
                      width: 340,
                      // decoration: BoxDecoration(
                      //     // border: Border.all(color: Colors.black),
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: Colors.white),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                obscureText: false,
                                controller: email,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _showMyDialog();
                                      },
                                      child: Icon(Icons.question_mark_rounded),
                                    ),
                                    label: Text('ID Admin'),
                                    hintText: 'Masukkan ID',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                validator: (email) {
                                  if (email == null || email.isEmpty) {
                                    return 'masukkan email';
                                  } else if (email == spasi) {
                                    return null;
                                  }
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: pass,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                label: Text('Password Admin'),
                                hintText: 'Masukkan password',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = true;
                                    });
                                  },
                                  onTapCancel: () {
                                    setState(() {
                                      _passwordVisible = false;
                                    });
                                  },
                                  child: Icon(_passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              validator: (pass) =>
                                  pass != null ? 'masukkan password' : null,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email.text,
                                            password: pass.text);
                                    await FirebaseMessaging.instance
                                        .subscribeToTopic('Penukaran');
                                    Fluttertoast.showToast(
                                        msg: 'Berhasil Login');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => home()));
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'wrong-password') {
                                      Fluttertoast.showToast(
                                          msg: 'salah password');
                                    }
                                    if (_formKey.currentState!.validate()) {}
                                  }
                                },
                                child: Text("Login"),
                              ),
                            )
                          ],
                        ),
                      ))
                  // TextField(
                  //   decoration: InputDecoration(
                  //     label: Text("Id")
                  //   ),
                  // )
                ],
              ),
            )),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Email : adminbottlecash@gmail.com'),
                Text('Password : Bottlecashadmin*1'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
