import 'dart:ffi';
import 'dart:math';
import 'dart:io';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'LoginPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bottle_cash_deployment_app/Service_auth/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisPage extends StatefulWidget {
  RegisPage({Key? key}) : super(key: key);

  @override
  State<RegisPage> createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  bool IsCheked = false;
  final _formKey = GlobalKey<FormState>();
  bool? checkboxIconFormFieldValue = false;
  bool showErrorMessage = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference dbref =
      FirebaseDatabase.instance.ref('pelanggan/bottlecash');

  //bool ?_passwordVisible;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  int id = 1;
  void autoincrement() {
    setState(() {
      id++;
    });
  }

  //late bool _passwordVisible;
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  static final RegExp numberRegExp = RegExp(r'[a-zA-Z]');
  final String spasi = " ";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  void iniState() {
    //_passwordVisible = false;
    dbref = FirebaseDatabase.instance.ref("pelanggan/bottlecash");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.arrow_back_ios_new_rounded),
      //   backgroundColor: Colors.transparent,
      // ),
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Asset/Ellipse 1.png"),
                  alignment: Alignment.topLeft)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 630,
                      width: 300,
                      // decoration:
                      //     BoxDecoration(border: Border.all(color: Colors.black)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                child: RichText(
                                    text: TextSpan(
                                        text: 'Registrasi',
                                        style: GoogleFonts.roboto(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                        ))),
                              ),
                            ),
                            SizedBox(
                              height: 55,
                            ),
                            //daftar dengan google
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Container(
                            //     height: 50,
                            //     width: 200,
                            //     child: Row(
                            //       children: [
                            //         Image(image: AssetImage("Asset/gugel.png")),
                            //         RichText(
                            //             text: TextSpan(
                            //                 text: 'Daftar dengan Google',
                            //                 style: GoogleFonts.roboto(
                            //                     fontSize: 12,
                            //                     fontWeight: FontWeight.w600,
                            //                     color: Colors.black)))
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            //form pengisian nama, email, password dan no. hp
                            Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: _formKey,
                                child: Column(
                                  children: [
                                    //form nama
                                    TextFormField(
                                      obscureText: false,
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        labelText: 'Nama',
                                        hintText: 'Nama Lengkap',
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //form email
                                    TextFormField(
                                      obscureText: false,
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        labelText: 'Email',
                                        hintText: 'contoh@gmail.com',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      //validasi untuk email
                                      validator: (email) => email != null &&
                                              !EmailValidator.validate(email)
                                          ? 'Masukkan Email'
                                          : null,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //form password
                                    TextFormField(
                                      obscureText: true,
                                      controller: _passController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        labelText: 'Password',
                                        hintText: 'Kata Sandi',
                                        filled: true,
                                        // suffixIcon: GestureDetector(
                                        //   onLongPress: () {
                                        //     setState(() {
                                        //       _passwordVisible = true;
                                        //     });
                                        //   },
                                        //   onLongPressUp: () {
                                        //     setState(() {
                                        //       _passwordVisible = false;
                                        //     });
                                        //   },
                                        //   child: Icon(_passwordVisible
                                        //       ? Icons.visibility
                                        //       : Icons.visibility_off),
                                        // ),
                                      ),
                                      //validasi untuk password
                                      validator: (PassCurrentValue) {
                                        RegExp regex = RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                        var passNonNullValue =
                                            PassCurrentValue ?? "";
                                        if (passNonNullValue.isEmpty) {
                                          return ('Masukkan Passoword');
                                        } else if (passNonNullValue.length <
                                            7) {
                                          return ('Password harus mempunyai 8 karakter');
                                        } else if (!regex
                                            .hasMatch(passNonNullValue)) {
                                          return ('Gunakan upper,lower,digit dan karakter spesial');
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // form no.hp
                                    TextFormField(
                                      obscureText: false,
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        labelText: 'No. HP',
                                        hintText: '08xxxxxxxxxx',
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.length < 11) {
                                          return 'Masukkan Nomor HP Anda';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: IsCheked,
                                            onChanged: (newValue) {
                                              setState(
                                                  () => IsCheked = newValue!);
                                            }),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                      text: TextSpan(
                                                          text:
                                                              'Setuju dengan Syarat & Ketentuan serta',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12))),
                                                  RichText(
                                                      text: TextSpan(
                                                          text:
                                                              'Kebijakan Privasi',
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    showErrorMessage
                                        ? Container(
                                            child: Column(
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                        text: 'Ceklis',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .red)))
                                              ],
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            // cek box privacy and policy

                            SizedBox(
                              height: 10,
                            ),
                            //button daftar dan fungsi validasi per form
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _submit();
                                  },
                                  child: const Text('Daftar'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFCCD640),
                                      onPrimary: Colors.black,
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //gesture untuk kembali ke login page
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: 'Sudah Punya Akun?',
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Login',
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800)))
                                  ],
                                ))
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  void _submit() async {
    Reference image = FirebaseStorage.instance
        .ref()
        .child('images/blank-profile-picture-973460_1280-300x300.jpg');
    String imageUrl = await image.getDownloadURL();
    final Email email = Email(
      body: 'ini body',
      recipients: [_emailController.text],
      subject: 'ini subject',
    );
    String koin = "5000";
    String botol = "0";
    String tutupbotol = "0";
    String labelbotol = "0";
    String tukar = " ";
    String nmrIndihome = "xxxx-xxxx-xxxx";

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
      if (IsCheked != true) {
        setState(() => showErrorMessage == true);
      } else if (IsCheked == false) {
        return null;
      }

      try {
        UserCredential userCredential =
            await authService.createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passController.text.trim());
        String uid = userCredential.user!.uid;
        if (userCredential.user != null) {
          Map<String, dynamic> pelanggan = {
            'nama': _nameController.text.toString(),
            'email': _emailController.text.toString(),
            'password': _passController.text.toString(),
            'nohp': _phoneController.text.toString(),
            'saldo': koin,
            'uid': uid,
            'botol': botol,
            'profilURL': imageUrl,
            'tutupbotol': tutupbotol,
            'labelbotol': labelbotol,
            'tukar': tukar,
            'nomor indihome': nmrIndihome,
          };
          dbref.child('/$uid').set(pelanggan);
          await pr.show();
          Fluttertoast.showToast(msg: "Berhasil daftar");

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          Fluttertoast.showToast(msg: "Akun sudah terdaftar");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(msg: 'Email Telah Terdaftar');
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
                Text('Akun telah terdaftar'),
                Text('Mohon masukkan akun baru'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('tutup'),
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
