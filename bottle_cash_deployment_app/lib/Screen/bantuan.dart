import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('Asset/Aset Page 1.png'),
            Text(
              "Halaman Bantuan Sedang Dalam Pengembangan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Ditunggu Untuk Updatenya",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
