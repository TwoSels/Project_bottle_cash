import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
