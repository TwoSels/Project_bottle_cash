import 'package:bottle_cash_deployment_app/Service_auth/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class notifikasipage extends StatefulWidget {
  notifikasipage({Key? key}) : super(key: key);

  @override
  State<notifikasipage> createState() => _notifikasipageState();
}

class _notifikasipageState extends State<notifikasipage> {
  final switchstate state = Get.put(switchstate());
  bool light1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCD640),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Notifikasi',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      body: Align(
          alignment: Alignment.center,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Card(
                  child: Container(
                      height: 100,
                      width: 370,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                              alignment: Alignment(-0.5, -0.2),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.circle_notifications,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Aktivitas',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Penukaran',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 200,
                              ),
                              GetBuilder<switchstate>(
                                  builder: (_) => Switch(
                                      value: state.isSwtiched,
                                      onChanged: ((value) {
                                        state.rubahstateswitch(value);
                                      })))
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          )),
    );
  }

  void onoffnotif() async {
    if (light1 == true) {
      await FirebaseMessaging.instance.subscribeToTopic('Penukaran');
      print('on');
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic('Penukaran');
      print('off');
    }
  }
}
