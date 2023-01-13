import 'dart:ui';
import 'package:bottle_cash_deployment_app/Home.dart';
import 'package:bottle_cash_deployment_app/Navbar/Persistent_navbar.dart';
import 'package:bottle_cash_deployment_app/Service_auth/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passwordfield/passwordfield.dart';
import 'RegisPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _text = TextEditingController();
  bool IsChecked = false;
  late bool _passwordVisible;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Box? box1;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();

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
      setState(() {});
    }
    if (box1?.get('email') != null) {
      pass.text = box1?.get('pass');
      IsChecked = true;
      setState(() {});
    }
  }

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
                height: 370,
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
                      height: 340,
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
                                    controller: pass,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFC5F114),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        suffixIcon: GestureDetector(
                                          onLongPress: () {
                                            setState(() {
                                              _passwordVisible = true;
                                            });
                                          },
                                          onLongPressUp: () {
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
                                        return ('Masukkan Passoword');
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
                                    setState(() {});
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
                                        builder: (context) => RegisPage(),
                                      ))),
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Lupa Passowrd",
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Persistent_navbar()));
                                }
                                // final isValidForm =
                                //     _formKey.currentState?.validate();

                                // if (isValidForm){

                                // }
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

                          // GestureDetector(
                          //   onTap: () {
                          //     login();
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => Home()));
                          //   },
                          //   child: Container(
                          //     height: 45,
                          //     width: 300,
                          //     padding: EdgeInsets.symmetric(vertical: 10),
                          //     alignment: Alignment.center,
                          //     decoration: BoxDecoration(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(11)),
                          //         boxShadow: <BoxShadow>[
                          //           BoxShadow(
                          //             color: Colors.grey.shade200,
                          //             offset: Offset(2, 4),
                          //             blurRadius: 5,
                          //             spreadRadius: 2,
                          //           ),
                          //         ],
                          //         color: Color(0xFF8DC13F)),
                          //     child: Text('LOGIN',
                          //         style: GoogleFonts.roboto(
                          //           fontSize: 20,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.white,
                          //         )),
                          //   ),
                          // ),

                          // GestureDetector(
                          //   onTap: () {
                          //     AuthService().signInwithGoogle();

                          //     if (GoogleSignInAccount == null) {
                          //       return;
                          //     }
                          //   },
                          //   child: Container(
                          //     height: 48,
                          //     width: 200,
                          //     child: Row(
                          //       children: [
                          //         Image(image: AssetImage("Asset/gugel.png")),
                          //         RichText(
                          //             text: TextSpan(
                          //                 text: 'Login dengan Google',
                          //                 style: GoogleFonts.roboto(
                          //                     fontSize: 12,
                          //                     fontWeight: FontWeight.w600,
                          //                     color: Colors.black)))
                          //       ],
                          //     ),
                          //   ),
                          // ),
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

  //fungsi validator email manual
  // String? validateEmail(String? value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = RegExp(pattern);
  //   if (!regex.hasMatch(value!))
  //     return 'Masukkan Email';
  //   else
  //     return null;
  // }

  void login() {
    if (IsChecked) {
      box1?.put('email', email.text);
      box1?.put('pass', pass.text);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  }
}
