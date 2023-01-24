import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class notifikasi_tampil {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/icon_logo");
    var initialzationSettingIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    var initializationSetting = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initialzationSettingIOS);
    await notificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future notifikasiTampil(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}

notificationDetails() {
  return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          icon: "@mipmap/icon_logo",
          priority: Priority.max,
          importance: Importance.max));
}

void requestpermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('user granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('user granted provisionam permission');
  } else {
    print('user declined or has not accepted permission');
  }
}
