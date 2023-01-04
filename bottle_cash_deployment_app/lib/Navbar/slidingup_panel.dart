import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class sliding_menu extends StatelessWidget {
  const sliding_menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("SlidingUpPanelExample"),
      ),
      body: SlidingUpPanel(
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
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
