import 'package:bottle_cash_deployment_app/Screen/Achievement.dart';
import 'package:bottle_cash_deployment_app/Screen/LoginPage.dart';
import 'package:bottle_cash_deployment_app/Navbar/slidingup_panel.dart';
import 'package:bottle_cash_deployment_app/Screen/editprofile.dart';
import 'package:bottle_cash_deployment_app/Screen/ewallet.dart';
import 'package:bottle_cash_deployment_app/Screen/nomorindihone.dart';
import 'package:bottle_cash_deployment_app/Screen/notifikasipage.dart';
import 'package:bottle_cash_deployment_app/Service_auth/auth_service.dart';
import 'package:bottle_cash_deployment_app/Screen/SpeedOnDemand.dart';
import 'package:bottle_cash_deployment_app/Screen/TagihanIndihome.dart';
import 'package:bottle_cash_deployment_app/Screen/Wifi_id.dart';
import 'package:bottle_cash_deployment_app/Service_auth/currentuserinfo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:bottle_cash_deployment_app/Card_component/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

import '../Notifikasi/notifikasi.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //deklarasi variable global
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User currentuser = auth.currentUser!;
  final LocalStorage storage = new LocalStorage('uid');
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String _name = "";
  final User user = FirebaseAuth.instance.currentUser!;
  String cekUid = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference profil = FirebaseDatabase.instance.ref();
  final foto = FirebaseDatabase.instance.ref('pelanggan/bottlecash');
  AuthService authService = AuthService();

  //variabel pemanggilan untuk setiap data dari realtime database
  var nama;
  var emailuser;
  var nohpuser;
  var saldouser;
  var botoluser;
  var laberuser;
  var tutupuser;
  var imageurl;

  //fungsi agar menjalankan state secara otomatis
  @override
  void initState() {
    requestpermission();
    profilberubah();
    super.initState();
  }

  //widget utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appbar
        appBar: AppBar(
          backgroundColor: Color(0xFFCCD640),
          toolbarHeight: 82,
          title: Container(
            child: Row(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 160,
                    child: Column(
                      children: [
                        Image.asset('Asset/Group 2.png'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //foto profil di appbar
          actions: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //widget untuk menampilkan imageurl dari user
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage('$imageurl'),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
            //button untuk menampilkan drawer
            Builder(
              builder: (context) => IconButton(
                icon: Icon(CupertinoIcons.ellipsis_vertical),
                // icon: IconButton(
                //     onPressed: () => Scaffold.of(context).openEndDrawer(),
                //     icon: ImageIcon(AssetImage('Asset/ICON.png'))),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
        ),
        //sidebar navigation
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: (Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //tambah gambar dari user
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage('$imageurl'),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    //menampilkan user info dari database
                    Container(
                        height: 80,
                        width: 200,
                        // decoration:
                        //     BoxDecoration(border: Border.all(color: Colors.black)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              //get nama dari user
                              Text(
                                '$nama',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              // get email dari user
                              Text(
                                '$emailuser',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              //get nohp user
                              Text(
                                '$nohpuser',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
              ),
              //listtile button
              ListTile(
                  leading: Icon(CupertinoIcons.square_pencil),
                  iconColor: Colors.black,
                  title: RichText(
                      text: TextSpan(
                          text: 'Edit Profile',
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700))),
                  onTap: () {
                    Navigator.pop(context);
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: editprofil(), withNavBar: false);
                  }),
              ListTile(
                leading: Icon(CupertinoIcons.bell_solid),
                iconColor: Colors.black,
                title: RichText(
                    text: TextSpan(
                        text: 'Notification',
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700))),
                onTap: () {
                  Navigator.pop(context);
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: notifikasipage(), withNavBar: false);
                },
              ),
              ListTile(
                leading: Icon(CupertinoIcons.phone_solid),
                iconColor: Colors.black,
                title: RichText(
                    text: TextSpan(
                        text: 'Nomor Indihome',
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700))),
                onTap: () {
                  Navigator.pop(context);
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: nomorindihone(), withNavBar: false);
                },
              ),
              ListTile(
                leading: Icon(CupertinoIcons.square_arrow_right_fill),
                iconColor: Colors.black,
                title: RichText(
                    text: TextSpan(
                        text: 'LogOut',
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700))),
                onTap: () {
                  // AuthService().signOutFromGoogle();
                  logout();
                  storage.clear();

                  Fluttertoast.showToast(msg: "Berhasil Keluar");
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: LoginPage(), withNavBar: false);
                },
              ),
              ListTile(
                title: Text('App Verion 1.0.0'),
              )
            ],
          ),
        ),
        //isi utama
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
              content: Text('Tekan Sekali lagi untuk menutup aplikasi')),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 1180,
                            width: 340,
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black),
                            // ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                //container id dan saldo bcash
                                Container(
                                  height: 90,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 147, 189, 75),
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //container id pelanggan
                                      Container(
                                        height: 60,
                                        width: 120,
                                        // decoration: BoxDecoration(
                                        //     border:
                                        //         Border.all(color: Colors.black)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.person_circle_fill,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                        text: 'User ID',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))),
                                                GestureDetector(
                                                  onTap: () {
                                                    _uidpelanggan();
                                                  },
                                                  child: Text(
                                                    'Lihat User ID',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      //bar pemisah
                                      Container(
                                        height: 30,
                                        width: 2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white)),
                                      ),
                                      //container saldo bcash pelanggan
                                      Container(
                                        height: 60,
                                        width: 120,
                                        // decoration: BoxDecoration(
                                        //     border:
                                        //         Border.all(color: Colors.black)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .money_rubl_circle_fill,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                        text: 'B-Cash',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))),
                                                Text(
                                                  '$saldouser',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                //keterangan history selama pemakaian aplikasi
                                Container(
                                  height: 90,
                                  width: 340,
                                  decoration: BoxDecoration(
                                      color: Color(0xC0B2F57B),
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 82,
                                        width: 320,
                                        // decoration: BoxDecoration(
                                        //     border:
                                        //         Border.all(color: Colors.black)),
                                        child: Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                        text:
                                                            'Sejak bergabung, kamu berhasil mengumpulkan',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '$botoluser pcs Botol Plastik',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        '$tutupuser pcs Tutup Botol',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                    '$laberuser pcs Label Botol',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    share();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      RichText(
                                                          text: TextSpan(
                                                              text:
                                                                  'Undang Teman untuk Bergabung',
                                                              style: GoogleFonts.roboto(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700))),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        CupertinoIcons
                                                            .right_chevron,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // menu tukar bcash
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: 'Tukar B-Cash',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black,
                                                  fontSize: 26,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //container menu row
                                Container(
                                  height: 94,
                                  width: 330,
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: Colors.black)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //menu indihome
                                      GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(context,
                                                  screen: TagihanIndohome(),
                                                  withNavBar: false);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset('Asset/indihome.png'),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'IndiHome',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600)))
                                          ],
                                        ),
                                      ),
                                      //menu wifi id
                                      GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(context,
                                                  screen: Wifi_id(),
                                                  withNavBar: false);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset('Asset/wifi_id.png'),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Wifi ID',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600)))
                                          ],
                                        ),
                                      ),
                                      //menu SOD
                                      GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(context,
                                                  screen: SODPage(),
                                                  withNavBar: false);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset('Asset/sod.png'),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Speed On',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Demand',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600)))
                                          ],
                                        ),
                                      ),
                                      //menu other/ewallet
                                      GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(context,
                                                  screen: ewalletpage(),
                                                  withNavBar: false);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset('Asset/other_icon.png'),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'E-Wallet',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //recomended item
                                Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: 'Recommended',
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w800))),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Explore Now',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              CupertinoIcons.arrow_right,
                                              size: 15,
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                //item per row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildcard(
                                        child: Container(
                                      height: 150,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'Asset/sepatu.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                          Text('Sepatu'),
                                          Text('Rp. 250.000')
                                        ],
                                      ),
                                    )),
                                    buildcard(
                                        child: Container(
                                      height: 150,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Image.asset(
                                            'Asset/gitar.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Gitar'),
                                          Text('Rp. 200.000')
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildcard(
                                        child: Container(
                                      height: 150,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'Asset/kursi hijau.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                          Text('Kursi'),
                                          Text('Rp. 50.000')
                                        ],
                                      ),
                                    )),
                                    buildcard(
                                        child: Container(
                                      height: 150,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'Asset/tanaman.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                          Text('Tanaman'),
                                          Text('Rp. 80.000')
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildcard(
                                        child: Container(
                                      height: 150,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'Asset/celana.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                          Text('Celana'),
                                          Text('Rp. 150.000')
                                        ],
                                      ),
                                    )),
                                    buildcard(
                                        child: Container(
                                      height: 150,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'Asset/baju.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                          Text('Baju'),
                                          Text('Rp. 70.000')
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  //fungsi pemanggilan data setiap user sesuai dari uid di database
  void profilberubah() {
    profil.child('/pelanggan/bottlecash/$cekUid/').onValue.listen((event) {
      print(event.snapshot.value.toString());
      Map profiluser = event.snapshot.value as Map;
      profiluser.forEach((key, value) {
        setState(() {
          nama = profiluser['nama'];
          emailuser = profiluser['email'];
          nohpuser = profiluser['nohp'];
          saldouser = profiluser['saldo'];
          botoluser = profiluser['botol'];
          tutupuser = profiluser['tutupbotol'];
          laberuser = profiluser['labelbotol'];
          imageurl = profiluser['profilURL'];
        });
      });
    });
  }

  //fungsi keluar aplikasi
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }

  void share() {
    Share.share(
        'Ayok jadi B-CASH RANGER dengan download aplikasi BOTTLECASH: https://play.google.com/store/apps/details?id=com.project.bottlecashapp&pli=1');
  }

  void shareuid() {
    Share.share('Kode akun unik kamu $cekUid');
  }

  //fungsi penampilah uid pelanggan
  Future<void> _uidpelanggan() async {
    final TextEditingController _koinbaru = new TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('User ID Kamu'),
                SizedBox(
                  height: 10,
                ),
                Text('$cekUid')
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Share'),
                  onPressed: () {
                    shareuid();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Tutup'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
