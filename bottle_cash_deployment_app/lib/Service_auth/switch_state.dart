import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class switchstate extends GetxController {
  var isSwtiched = false;
  var nyala = FirebaseMessaging.instance.unsubscribeFromTopic('Penukaran');

  final switchdata = GetStorage();

  switchstate() {
    print('panggil konstruktor');
    if (switchdata.read('switch') != null) {
      isSwtiched = switchdata.read('switch');
      update();
    }
  }
  rubahstateswitch(bool nyala) {
    isSwtiched = nyala;
    switchdata.write('switch', isSwtiched);
    update();
  }
}
