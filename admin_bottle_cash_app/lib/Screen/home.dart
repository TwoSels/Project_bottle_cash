import 'package:admin_bottle_cash_app/Screen/login_page.dart';
import 'package:admin_bottle_cash_app/Screen/reset_bcash.dart';
import 'package:admin_bottle_cash_app/Screen/reset_kodegembok.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('Home'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            height: 500,
            width: 350,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Container(
                  height: 240,
                  width: 280,
                  child: Image.asset("asset/Aset Page 1.png"),
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => reset_bcash()));
                    },
                    child: Text('Reset B-Cash User'),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => reset_gembok()));
                    },
                    child: Text('Ubah Kode Gembok'),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_page()));
                    },
                    child: Text('Keluar'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
