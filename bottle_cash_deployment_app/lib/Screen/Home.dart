import 'package:bottle_cash_deployment_app/Screen/Achievement.dart';
import 'package:bottle_cash_deployment_app/Screen/LoginPage.dart';
import 'package:bottle_cash_deployment_app/Navbar/slidingup_panel.dart';
import 'package:bottle_cash_deployment_app/Service_auth/auth_service.dart';
import 'package:bottle_cash_deployment_app/Screen/SpeedOnDemand.dart';
import 'package:bottle_cash_deployment_app/Screen/TagihanIndihome.dart';
import 'package:bottle_cash_deployment_app/Screen/Wifi_id.dart';
import 'package:bottle_cash_deployment_app/Service_auth/currentuserinfo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User currentuser = auth.currentUser!;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Query dbref = FirebaseDatabase.instance.ref().child('pelanggan/bottlecash');
  final database = FirebaseDatabase.instance.ref();
  final LocalStorage storage = new LocalStorage('uid');
  final _userProfil = Hive.box('userProfil');
  String _name = "";

  AuthService authService = AuthService();

  @override
  void initState() {
    final userData = storage.getItem('UserData');
    //final Profil = jsonDecode(userData);
    super.initState();
    // FirebaseDatabase.instance
    //     .ref('pelanggan/bottlecash')
    //     .once()
    //     .then((DataSnapshot snapshot) {
    //   print(snapshot.value);
    // });
    setState(() {
      //_name = userData.name;
    });
    //print(Profil);
  }

  // Widget listView({required Map pelanggan}) {
  //   return Column(
  //     children: [
  //       Text(pelanggan['nama']),
  //       Text(pelanggan['email']),
  //       Text(pelanggan['nohp'])
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Image.asset('Asset/telkom.png'),
                // )
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ProfilePicture(
                    //   name: 'Anya',
                    //   radius: 29,
                    //   fontsize: 21,
                    //   random: true,
                    // ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('Asset/profil.png'),
                      radius: 30,
                    ),
                  ]),
            ),
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
                    // ProfilePicture(
                    //   name: 'Anya',
                    //   radius: 29,
                    //   fontsize: 21,
                    //   random: true,
                    // ),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      backgroundImage: AssetImage('Asset/profil.png'),
                      radius: 30,
                    ),
                    Container(
                        height: 70,
                        width: 160,
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
                              // Expanded(
                              //   child: StreamBuilder <QuerySnapshot> (
                              //   stream: FirebaseDatabase.instance.ref('pelanggan/bottlecash').child('/').get(),
                              //   builder: (context, snapshot) {
                              //   return
                              //   })),

                              // Container(
                              //   height: 50,
                              //   child: FirebaseAnimatedList(
                              //       query: dbref,
                              //       itemBuilder:
                              //           ((context, snapshot, animation, index) {
                              //         print(context);
                              //         print(snapshot);
                              //         print(animation);
                              //         print(index);
                              //         if (currentuser.uid == true ||
                              //             currentuser. != null) {
                              //           Map pelanggan = snapshot.value as Map;
                              //           pelanggan['key'] = snapshot.key;
                              //           return listView(pelanggan: pelanggan);
                              //         }
                              //         return Text('no user');
                              //       })),
                              // ),
                              //Text(FirebaseAuth.instance.currentUser!.email!),

                              // Text(FirebaseDatabase.instance
                              //     .ref('pelanggan/bottlecash')
                              //     .child('nohp')
                              //     .get()
                              //     .toString()),

                              // // get nama user dari database

                              // RichText(
                              //     text: TextSpan(
                              //         text: '%nama user%',
                              //         style: GoogleFonts.roboto(
                              //             color: Colors.black,
                              //             fontSize: 20,
                              //             fontWeight: FontWeight.bold))),
                              // //get email user dari database
                              // Text(
                              //   FirebaseAuth.instance.currentUser!.email!,
                              //   style: TextStyle(fontSize: 14),
                              // ),

                              // //get nomor hp user dari database
                              // RichText(
                              //     text: TextSpan(
                              //         text: '%nomor user%',
                              //         style: GoogleFonts.roboto(
                              //             color: Colors.black,
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.w400))),
                            ],
                          ),
                        )),
                  ],
                )),
              ),
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
                  onTap: () async {
                    print(_userProfil.get(1));
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
                onTap: () {},
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
                onTap: () {},
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
                  _userProfil.delete(1);
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
                                                RichText(
                                                    text: TextSpan(
                                                        text: 'BC-001',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))),
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
                                                RichText(
                                                    text: TextSpan(
                                                        text: '0',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))),
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
                                                  height: 5,
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                        text:
                                                            '0 Pcs Botol Plastik 0 Pcs Tutup Botol 0 Pcs Label',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
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
                                //menu row
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
                                      //menu other
                                      GestureDetector(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Image.asset('Asset/other_icon.png'),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Other',
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

  Future<DataSnapshot> snapshot() {
    if (currentuser.uid == auth || currentuser == true) {}
    return snapshot();
  }

  cekuid() async {
    final uid = storage.getItem('uid');
    DatabaseReference coba = FirebaseDatabase.instance.ref();
    final data = await coba.child('/pelanggan/bottlecash/$uid').get();
    print('data value = $data.value');
    print('cek storage = $uid');
    return data.value;
    // print(storage.getItem('uid'));
    //await ref.set({'name': '2000'});
    // final cek = await ref.child('pelanggan/bottlecash').get();
    // if (cek.exists) {
    //   print(cek.value);
    // } else {
    //   print('No data available.');
    // }
    // print(cek.value);
  }

  Future<void> _deleteCacheDir() async {
    final tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDocDir = await getApplicationDocumentsDirectory();

    if (appDocDir.existsSync()) {
      appDocDir.deleteSync(recursive: true);
    }
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }
}
