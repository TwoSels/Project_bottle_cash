import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class halaman_bantuan extends StatefulWidget {
  halaman_bantuan({Key? key}) : super(key: key);

  @override
  State<halaman_bantuan> createState() => _halaman_bantuanState();
}

class _halaman_bantuanState extends State<halaman_bantuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        title: Center(
          child: Text(
            'Bantuan',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
          child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              width: 280,
              child: Image.asset("Asset/Aset Page 1.png"),
            ),
            Text(
              'Untuk informasi lebih lanjut bisa hubungi kesini ya',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () async {
                      await openUrl(
                          'https://www.instagram.com/bottle.cash/?next=%2F');
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('Asset/instagram.png'),
                    )),
                GestureDetector(
                    onTap: () async {
                      await openUrl('https://wa.me/6281288364816');
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('Asset/whatsapp.png'),
                    )),
                GestureDetector(
                    onTap: () {
                      _sendemail();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset('Asset/gmail.png'),
                    )),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Future<void> openUrl(String url,
      {bool forceWebView = false, bool enableJavaScript = false}) async {
    await launch(url);
  }

  void _sendemail() async {
    final Email email = Email(
        body: ' ',
        subject: ' ',
        recipients: ['bottlecash.id@gmail.com'],
        isHTML: false);
    await FlutterEmailSender.send(email);
  }
}
