import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanIndohome extends StatefulWidget {
  TagihanIndohome({Key? key}) : super(key: key);

  @override
  State<TagihanIndohome> createState() => _TagihanIndohomeState();
}

class _TagihanIndohomeState extends State<TagihanIndohome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        title: Text(
          'TAGIHAN INDIHOME',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
