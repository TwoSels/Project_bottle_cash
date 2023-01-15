import 'package:admin_bottle_cash_app/Screen/home.dart';
import 'package:admin_bottle_cash_app/persistent_navbar/persistent_navbar.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
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
                    height: 210,
                    width: 340,
                    // decoration: BoxDecoration(
                    //     // border: Border.all(color: Colors.black),
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: Colors.white),
                    child: Column(
                      children: [
                        TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                              label: Text('ID Admin'),
                              hintText: 'Masukkan ID',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              label: Text('Password Admin'),
                              hintText: 'Masukkan ID',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => home()));
                            },
                            child: Text("Login"),
                          ),
                        )
                      ],
                    ),
                  )
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
}
