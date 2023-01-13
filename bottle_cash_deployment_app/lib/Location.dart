import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Color(0xFFCCD640),
        elevation: 5,
        title: Center(
          child: Text(
            'Location',
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SlidingUpPanel(
        minHeight: 70,
        panel: Center(
            child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [Text('data')],
            ),
          ),
        )),
        collapsed: Container(
          decoration:
              BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
          child: Center(
            child: Text(
              "This is the collapsed Widget",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Center(
          child: Text("This is the Widget behind the sliding panel"),
        ),
        borderRadius: radius,
      ),
    );
  }
}
