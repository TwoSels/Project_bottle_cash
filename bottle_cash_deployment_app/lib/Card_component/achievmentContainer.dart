import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildcard3() => Container(
      width: 360,
      height: 430,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.green, width: 5),
          image: DecorationImage(
              image: AssetImage('Asset/Ellipse 6.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover)
          // border: BoxBorder(
          //   Padding(padding: EdgeInsets.fromLTRB(20.0, 12.0, 12.0, 12.0)),
          // ),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 5,
          //     //offset: Offset(4, 4),
          //     spreadRadius: 3,
          //   ),
          // ],
          ),
      padding: EdgeInsets.fromLTRB(27, 22, 27, 22),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Terdaftar sebagai',
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700))),
                  RichText(
                      text: TextSpan(
                          text: 'B-CASH RANGER',
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold))),
                  RichText(
                      text: TextSpan(
                          text: 'Sejak Des 2022',
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700))),
                ],
              ),
              Container(
                height: 50,
                width: 50,
                child: Image.asset('Asset/achieve_icon.png'),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 20,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
                color: Colors.black),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Saya, %nama user%',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700))),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 120,
            width: 420,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff204172)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 100,
                  width: 280,
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Mengumpulkan',
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: '%hsl% TUTUP BOTOL',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: '%hsl% LABEL BOTOL PLASTIK',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: '%hsl% BOTOL PLASTIK',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))),
                            ],
                          ),
                          Container(
                            height: 55,
                            width: 2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Berhasil',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'didaur ulang',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'bersama',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Bottle Cash',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Ayo bergabung dengan',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'saya untuk berkontribusi',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'lebih kepada LINGKUNGAN !',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '#SemuanyaberNilai',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      )),
    );
