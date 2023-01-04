import 'package:bottle_cash_deployment_app/Achievement.dart';
import 'package:bottle_cash_deployment_app/LoginPage.dart';
import 'package:bottle_cash_deployment_app/Navbar/slidingup_panel.dart';
import 'package:bottle_cash_deployment_app/SpeedOnDemand.dart';
import 'package:bottle_cash_deployment_app/TagihanIndihome.dart';
import 'package:bottle_cash_deployment_app/Wifi_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:bottle_cash_deployment_app/Card_component/card.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  ProfilePicture(
                    name: 'Anya',
                    radius: 29,
                    fontsize: 21,
                    random: true,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //tambah gambar dari user
                  ProfilePicture(
                    name: 'Anya',
                    radius: 29,
                    fontsize: 21,
                    random: true,
                  ),
                  Container(
                    height: 70,
                    width: 160,
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //get nama user dari database
                        RichText(
                            text: TextSpan(
                                text: '% nama user %',
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        //get nama user dari database
                        RichText(
                            text: TextSpan(
                                text: '% email user %',
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))),
                        RichText(
                            text: TextSpan(
                                text: '% nomor user %',
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
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
              onTap: () {},
            ),
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
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: LoginPage(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
            ListTile(
              title: Text('App Verion 1.0.0'),
            )
          ],
        ),
      ),
      body: Container(
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
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'BC-%id%',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500))),
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
                                        border:
                                            Border.all(color: Colors.white)),
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
                                          CupertinoIcons.money_rubl_circle_fill,
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
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                            RichText(
                                                text: TextSpan(
                                                    text: '%saldo%',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500))),
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
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            RichText(
                                                text: TextSpan(
                                                    text:
                                                        '%hsl% Pcs Botol Plastik %hsl% Pcs Tutup Botol %hsl% Pcs Label',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600))),
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
                                                          style: GoogleFonts
                                                              .roboto(
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
                                              fontWeight: FontWeight.bold))),
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
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
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
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
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
                                      PersistentNavBarNavigator.pushNewScreen(
                                          context,
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
                                    onTap: () {
                                      showBottomSheet(
                                          context: context,
                                          builder: (context) => sliding_menu());
                                    },
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }
}
