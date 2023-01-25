import 'package:bottle_cash_deployment_app/Screen/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class resetpassword extends StatefulWidget {
  resetpassword({Key? key}) : super(key: key);

  @override
  State<resetpassword> createState() => _resetpasswordState();
}

class _resetpasswordState extends State<resetpassword> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Reset Password'),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Icon(Icons.arrow_back),
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 450,
                  width: 300,
                  child: Column(
                    children: [
                      Image.asset('Asset/login_1.png'),
                      Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(5)),
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
                            )
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
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(
                                        email: _emailController.text);
                                Fluttertoast.showToast(
                                    msg: "Silahkan Cek Email");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  Fluttertoast.showToast(
                                      msg: 'Email Tidak Ada');
                                }
                              }
                            }
                            // final isValidForm =
                            //     _formKey.currentState?.validate();

                            // if (isValidForm){

                            // }
                          },
                          child: const Text('RESET'),
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
        ),
      ),
    );
  }

  void resetpass() async {}
}
