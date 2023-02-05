import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AchievmentPage extends StatefulWidget {
  AchievmentPage({Key? key}) : super(key: key);

  @override
  State<AchievmentPage> createState() => _AchievmentPageState();
}

class _AchievmentPageState extends State<AchievmentPage> {
  ScreenshotController screenshotController = ScreenshotController();
  String cekUid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference profil = FirebaseDatabase.instance.ref();

  var nama;
  var botoluser;
  var laberuser;
  var tutupuser;

  @override
  void initState() {
    super.initState();
    getprofil();
    setState(() {});
  }

  Widget AchievmentCard() => Container(
        height: 456,
        width: 360,
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
                child: Center(
                  child: Text(
                    'Saya, $nama',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
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
                                Text(
                                  '$botoluser BOTOL PLASTIK',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$laberuser LABEL BOTOL PLASTIK',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$tutupuser TUTUP BOTOL PLASTIK',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 77,
                          ),
                          SizedBox(
                            height: 28,
                            width: 28,
                            child: Image.asset('Asset/instagram.png'),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '@bottle.cash',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Color(0xFFCCD640),
        elevation: 5,
        title: Center(
            child: Row(
          children: [
            SizedBox(
              width: 125,
            ),
            Text(
              'Achievement',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        )),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('Asset/Rectangle 6.png'),
            alignment: Alignment.topCenter,
          )),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: 587,
              width: 360,
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: AchievmentCard(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    width: 130,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        CupertinoIcons.share,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        print(cekUid);
                        final image = await screenshotController
                            .captureFromWidget(AchievmentCard());

                        if (image == null) return toast();
                        await saveImage(image);
                        saveAndShare(image);
                        toast();
                      },
                      label: const Text(
                        'Bagikan',
                        style: TextStyle(color: Colors.grey),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 76,
                    width: 120,
                    child: Image.asset("Asset/gambarlogo.png"),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'Achievement Bottle Cash';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filePath'];
  }

  toast() {
    Fluttertoast.showToast(
        msg: 'gambar disimpan',
        textColor: Colors.white,
        backgroundColor: Colors.grey,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 14);
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/Pencapaian Bottle Cash.png');
    image.writeAsBytesSync(bytes);

    await Share.shareFiles([image.path]);
  }

  void getprofil() {
    profil.child('/pelanggan/bottlecash/$cekUid/').onValue.listen((event) {
      //print(event.snapshot.value.toString());
      Map profiluser = event.snapshot.value as Map;
      profiluser.forEach((key, value) {
        setState(() {
          nama = profiluser['nama'];
          botoluser = profiluser['botol'];
          tutupuser = profiluser['tutupbotol'];
          laberuser = profiluser['labelbotol'];
        });
      });
    });
  }
}
