import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum paket_wifi { paket12, paket7, paket30 }

class Wifi_id extends StatefulWidget {
  Wifi_id({Key? key}) : super(key: key);

  @override
  State<Wifi_id> createState() => _Wifi_idState();
}

class _Wifi_idState extends State<Wifi_id> {
  paket_wifi? _character = paket_wifi.paket12;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Color(0xFFCCD640),
          elevation: 5,
          title: Text(
            'Wifi.id Seamless',
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
                            text: 'Paket Harga Voucher @wifi.id',
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    ListTile(
                      title: const Text('Paket 12 Jam Rp. 5.000'),
                      leading: Radio<paket_wifi>(
                        value: paket_wifi.paket12,
                        groupValue: _character,
                        onChanged: (paket_wifi? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Paket 7 Hari Rp. 20.000'),
                      leading: Radio<paket_wifi>(
                        value: paket_wifi.paket7,
                        groupValue: _character,
                        onChanged: (paket_wifi? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Paket 30 Hari Rp. 50.000'),
                      leading: Radio<paket_wifi>(
                        value: paket_wifi.paket30,
                        groupValue: _character,
                        onChanged: (paket_wifi? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
