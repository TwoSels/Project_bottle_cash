import 'dart:convert';
import 'dart:ui';
import 'package:bottle_cash_deployment_app/Screen/Home.dart';
import 'package:bottle_cash_deployment_app/Navbar/Persistent_navbar.dart';
import 'package:bottle_cash_deployment_app/Service_auth/auth_service.dart';
import 'package:bottle_cash_deployment_app/Screen/resetpassword.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passwordfield/passwordfield.dart';
import 'RegisPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:localstorage/localstorage.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _text = TextEditingController();
  bool IsChecked = false;
  late bool _passwordVisible;
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();

  final LocalStorage storage = new LocalStorage('uid');
  Box? box1;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _userProfil = Hive.box('userProfil');

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();

    createBox();
    getdata();
  }

//fungsi ingat saya
  void createBox() async {
    box1 = await Hive.openBox('logindata');
    getdata();
  }

  void getdata() async {
    if (box1?.get('email') != null) {
      email.text = box1?.get('email');
      IsChecked = true;
      if (mounted) setState(() {});
    }
    if (box1?.get('email') != null) {
      pass.text = box1?.get('pass');
      IsChecked = true;
      if (mounted) setState(() {});
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   email.dispose();
  //   pass.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC5F114),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 240,
                  width: 280,
                  child: Image.asset("Asset/login_1.png"),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Hallo!',
                    style: GoogleFonts.roboto(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: '#SemuanyaberNilai',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey)),
              ),
              Container(
                height: 70,
                width: 70,
                child: Image.asset("Asset/Logo ABN.png"),
              ),
              Container(
                height: 380,
                width: 390,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                //isi widget buat form dan button
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 330,
                      width: 300,
                      child: Column(
                        children: [
                          Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  //Email Textfield
                                  TextFormField(
                                    controller: _emailController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFC5F114),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        prefixIcon: Icon(Icons.email_outlined),
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: 'Email',
                                        hintText: 'Email'),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (email) => email != null &&
                                            !EmailValidator.validate(email)
                                        ? 'Masukkan Email'
                                        : null,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //Password Textfield
                                  TextFormField(
                                    obscureText: !_passwordVisible,
                                    controller: _passController,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFC5F114),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            if (mounted)
                                              setState(() {
                                                _passwordVisible = true;
                                              });
                                          },
                                          onTapCancel: () {
                                            if (mounted)
                                              setState(() {
                                                _passwordVisible = false;
                                              });
                                          },
                                          child: Icon(_passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        prefixIcon: Icon(Icons.lock),
                                        fillColor: Colors.white,
                                        filled: true,
                                        labelText: 'Password',
                                        hintText: 'Password'),
                                    validator: (PassCurrentValue) {
                                      RegExp regex = RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                      var passNonNullValue =
                                          PassCurrentValue ?? "";
                                      if (passNonNullValue.isEmpty) {
                                        return ('Masukkan Password');
                                      } else if (passNonNullValue.length < 7) {
                                        return ('Password harus mempunyai 8 karakter');
                                      } else if (!regex
                                          .hasMatch(passNonNullValue)) {
                                        return ('Gunakan upper,lower,digit dan karakter spesial');
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )),

                          // SizedBox(
                          //   height: 25,
                          // ),
                          Row(
                            children: [
                              //fitur ingat saya
                              Checkbox(
                                  value: IsChecked,
                                  onChanged: ((value) {
                                    IsChecked = !IsChecked;
                                    if (mounted) setState(() {});
                                  })),
                              RichText(
                                  text: TextSpan(
                                      text: "Ingat Saya",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ))),
                              SizedBox(
                                width: 70,
                              ),
                              //fitur lupa password
                              GestureDetector(
                                  onTap: (() => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => resetpassword(),
                                      ))),
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Lupa Password",
                                          style: GoogleFonts.roboto(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                          ))))
                            ],
                          ),
                          SizedBox(
                            height: 45,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                _submit();
                              },
                              child: const Text('LOGIN'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF8DC13F),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum memiliki akun?',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisPage()));
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Daftar Yuk',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF8DC13F)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (IsChecked) {
      box1?.put('email', _emailController.text);
      box1?.put('pass', _passController.text);
    }
  }

  void _submit() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    final ProgressDialog pr = ProgressDialog(context);

    pr.style(
      progress: 50.0,
      message: "Please wait...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    if (_formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passController.text.trim());
        //await pr.show();
        //print(credential.user?.uid);
        final uid = credential.user?.uid;
        final userData =
            await database.child('pelanggan/bottlecash/$uid').get();
        //final profil = jsonDecode(userData);
        DatabaseEvent event = await FirebaseDatabase.instance
            .ref('pelanggan/bottlecash/$uid')
            .once();

        //Map<Object?, Object?>.from(event.snapshot.value);
        final nama = event.snapshot.value;
        _userProfil.put(1, userData.value);
        await FirebaseMessaging.instance.subscribeToTopic('Penukaran');
        //print(_userProfil.get(1));
        // print('hasil cek user: $nama');
        // await storage.setItem('UserData', userData.value);
        // final cek = storage.getItem('UserData');
        // print('hasil cek storage: $cek');
        //final data = await storage.getItem('UserData');
        //print(data);
        //print(userData.value);
        getdata();
        login();
        Fluttertoast.showToast(msg: "Berhasil Login");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Persistent_navbar()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: 'Email belum terdaftar');
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: 'Password salah');
        }
      }
    }
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
                Text('Akun belum terdaftar'),
                Text('Mohon daftar akun dulu ya'),
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
