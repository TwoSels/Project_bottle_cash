import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bottle_cash_deployment_app/Card_component/achievmentContainer.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:screenshot/screenshot.dart';

class AchievmentPage extends StatefulWidget {
  AchievmentPage({Key? key}) : super(key: key);

  @override
  State<AchievmentPage> createState() => _AchievmentPageState();
}

class _AchievmentPageState extends State<AchievmentPage> {
  ScreenshotController screenshotController = ScreenshotController();
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
              'Achievment',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        )),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(CupertinoIcons.refresh),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
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
                    child: buildcard3(),
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
                        final image = await screenshotController
                            .captureFromWidget(buildcard3());

                        if (image == null) return toast();
                        await saveImage(image);
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
                    height: 100,
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
}
