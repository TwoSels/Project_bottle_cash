import 'package:flutter/material.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildcard({required Widget child}) => Container(
      // width: 400,
      // height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: Border.all(color: Colors.green, width: 5),
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

Widget cardWidget() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ClipRRect(
        //   borderRadius: const BorderRadius.horizontal(
        //     left: Radius.circular(16),
        //   ),
        //   child: Image.network(
        //     'https://mhtwyat.com/wp-content/uploads/2022/02/%D8%A7%D8%AC%D9%85%D9%84-%D8%A7%D9%84%D8%B5%D9%88%D8%B1-%D8%B9%D9%86-%D8%A7%D9%84%D8%B1%D8%B3%D9%88%D9%84-%D8%B5%D9%84%D9%89-%D8%A7%D9%84%D9%84%D9%87-%D8%B9%D9%84%D9%8A%D9%87-%D9%88%D8%B3%D9%84%D9%85-1-1.jpg',
        //     width: 100,
        //     height: 100,
        //     fit: BoxFit.cover,
        //   ),
        // ),

        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Description",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

  // Widget buildImage(Uint8List bytes) => Image.memory(bytes);