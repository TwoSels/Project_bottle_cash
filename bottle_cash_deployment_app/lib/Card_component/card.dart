import 'package:flutter/material.dart';

Widget buildcard({required Widget child}) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: BoxBorder(
        //   Padding(padding: EdgeInsets.fromLTRB(20.0, 12.0, 12.0, 12.0)),
        // ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            //offset: Offset(4, 4),
            spreadRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(27, 22, 27, 22),
      child: child,
    );

Widget buildcard2({required Widget child}) => Card(
      elevation: 15,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Padding(padding: EdgeInsets.all(20)),
    );
