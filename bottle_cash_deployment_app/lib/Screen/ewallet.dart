import 'package:bottle_cash_deployment_app/Screen/Screen%20ewallet/dana.dart';
import 'package:bottle_cash_deployment_app/Screen/Screen%20ewallet/gopay.dart';
import 'package:bottle_cash_deployment_app/Screen/Screen%20ewallet/linkaja.dart';
import 'package:bottle_cash_deployment_app/Screen/Screen%20ewallet/ovo.dart';
import 'package:flutter/material.dart';

class ewalletpage extends StatefulWidget {
  ewalletpage({Key? key}) : super(key: key);

  @override
  State<ewalletpage> createState() => _ewalletpageState();
}

class _ewalletpageState extends State<ewalletpage> {
  //widget utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('E-Wallet',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            //button ke halaman penukaran linkaja
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => linkaja()));
              },
              child: Container(
                height: 60,
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(4, 4),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 40,
                      child: Image.asset('Asset/linkaja.png'),
                    ),
                    Text(
                      'Penukaran Saldo Link Aja',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            //button ke halaman penukaran gopay
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => gopay()));
              },
              child: Container(
                height: 60,
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(4, 4),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 80,
                      child: Image.asset('Asset/Gopay-Logo.png'),
                    ),
                    Text(
                      'Penukaran Saldo Gopay',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            //button ke halaman penukaran ovo
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ovo()));
              },
              child: Container(
                height: 60,
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(4, 4),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      width: 40,
                      height: 30,
                      child: Image.asset('Asset/ovo.png'),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Text(
                      'Penukaran Saldo OVO',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            //button ke halaman penukaran dana
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => dana()));
              },
              child: Container(
                height: 60,
                width: 290,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(4, 4),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: 60,
                      height: 40,
                      child: Image.asset('Asset/dana_logo.jpeg'),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'Penukaran Saldo Dana',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
