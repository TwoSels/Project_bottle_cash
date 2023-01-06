import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum paket_wifi { paket1, paket2, paket3 }

class SODPage extends StatefulWidget {
  SODPage({Key? key}) : super(key: key);

  @override
  State<SODPage> createState() => _SODPageState();
}

class _SODPageState extends State<SODPage> {
  paket_wifi? _character = paket_wifi.paket1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Color(0xFFCCD640),
          elevation: 5,
          title: Text(
            'Speed On Demand',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 590,
                width: 330,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black),
                // ),
                child: Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Paket Harga Speed On Demand',
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    ListTile(
                      title: const Text('1 Day Boost 30 Mbps \nRp. 40.000'),
                      leading: Radio<paket_wifi>(
                        value: paket_wifi.paket1,
                        groupValue: _character,
                        onChanged: (paket_wifi? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('1 Day Boost 40 Mbps \nRp. 74.000'),
                      leading: Radio<paket_wifi>(
                        value: paket_wifi.paket2,
                        groupValue: _character,
                        onChanged: (paket_wifi? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('7 Day Boost 40 Mbps \n Rp. 260.000'),
                      leading: Radio<paket_wifi>(
                        value: paket_wifi.paket3,
                        groupValue: _character,
                        onChanged: (paket_wifi? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Tukar B-Cash'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.asset("Asset/gambarlogo.png"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
