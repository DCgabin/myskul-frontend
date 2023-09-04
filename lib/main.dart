import 'dart:convert';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:myskul/controllers/chat_controller.dart';
import 'package:myskul/screens/chat/chat_group_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myskul/models/user.dart';
import 'package:myskul/screens/auth/login.dart';
import 'package:myskul/screens/home.dart';
import 'package:myskul/utilities/colors.dart';
import 'screens/splash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myskul/translations/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

bool?
    seen; // Cette variable va permettre d'afficher le splash screen une seule fois
String? token; // Token d'authentification de l'utlisateur
String? locale; // Cette variable nous permettra de gérer la langue utilisée
String?
    fmToken; // Cette variable nous permettra d'envoyer des notifications sur chaque appareil
late User user; // Ici sera stocké l'utilisateur principal

// fonction pour capture les notification et faire des actions lorsqu'on les reçoit
// @pragma("vm:entry-point")
// Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final prefs = await _prefs;
//     var userString = await prefs.getString('user');
//     var userJson = jsonDecode(userString!);
//     user = User.fromJson(userJson);
//   Get.to(() => GroupChat(user: user));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialisation de firebase

  // Initialisation de firebase messaging et awesome notifications
  // await messagingInit();

  // Initialisation du package SharedPreferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;

  // lignes de codes afférentes aux SharedPreferences

  await shMethods(prefs);
  await getUser(prefs);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(Home1()),
  );
}

getUser(SharedPreferences prefs) async {
  var userString = await prefs.getString('user');
  if (userString != null) {
    var userJson = jsonDecode(userString);
    user = User.fromJson(userJson);
  }
}

Future<void> shMethods(SharedPreferences prefs) async {
  seen = await prefs.getBool('first');
  token = await prefs.getString('token');
  // fmToken = await prefs.getString('fmToken');
  locale = await prefs.getString('locale');

  if (locale != null) {
    Get.updateLocale(Locale(locale!));
  }
  // if (fmToken == null) {
  //   var tmp = await ChatController().getFmToken();
  //   await prefs.setString('fmToken', tmp);
  // }
}

// Future<void> messagingInit() async {
//   FirebaseMessaging.onBackgroundMessage(notify);
//   // await AwesomeNotifications().setListeners(
//   //   onActionReceivedMethod: onActionReceivedMethod,
//   // );

//   FirebaseMessaging.instance
//       .setForegroundNotificationPresentationOptions(alert: true, sound: true);
//   FirebaseMessaging.onMessage.listen(
//     (m) {
//     //  notify(m);
//     },
//   );

//   FirebaseMessaging.onMessageOpenedApp.listen(
//     (m) {
//       print("OnMessageOpenedAp : ${m.data}");
//     },
//   );

//   // AwesomeNotifications().initialize(
//   //   'resource://drawable/res_app_ico',
//   //   [
//   //     NotificationChannel(
//   //       channelKey: 'MySkul',
//   //       channelName: 'MySkul',
//   //       channelDescription: 'MySkul Notification',
//   //       playSound: true,
//   //       importance: NotificationImportance.Max,
//   //       defaultColor: ColorHelper().green,
//   //       ledColor: Colors.white,
//   //       icon: 'resource://drawable/res_app_ico',
//   //     ),
//   //   ],
//   //   debug: true,
//   // );

// }

class Home1 extends StatefulWidget {
  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  Map<int, Color> color = {
    50: ColorHelper().white.withOpacity(0),
    100: ColorHelper().white.withOpacity(0),
    200: ColorHelper().white.withOpacity(0),
    300: ColorHelper().white.withOpacity(0),
    400: ColorHelper().white.withOpacity(0),
    500: ColorHelper().white.withOpacity(0),
    600: ColorHelper().white.withOpacity(0),
    700: ColorHelper().white.withOpacity(0),
    800: ColorHelper().white.withOpacity(0),
    900: ColorHelper().white.withOpacity(0),
  };

  @override
  void initState() {
    // AwesomeNotifications().isNotificationAllowed().then((value) {
    //   if (!value) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = ColorHelper().green
      ..backgroundColor = Colors.white
      ..indicatorColor = ColorHelper().green
      ..textColor = ColorHelper().green
      ..maskColor = Color.fromARGB(255, 24, 25, 26).withOpacity(0.1)
      ..userInteractions = false
      ..dismissOnTap = false;

    return GetMaterialApp(
      translations: Messages(),
      locale: Get.locale ?? Get.deviceLocale,
      fallbackLocale: Locale('fr', 'FR'),
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Scaffold(
        body: seen == null || seen == false
            ? Splash()
            : token == null
                ? Login()
                : Home(user: user),

        // body: Test(),
      ),
    );
  }
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

// Future notify(RemoteMessage m) async {
//   var tmp = m.data as Map;
//   var local = Get.locale;

//   //* AwesomeNotifications().createNotification(
//   //     content: NotificationContent(
//   //       id: createUniqueId(),
//   //       channelKey: 'MySkul',
//   //       title: tmp['nom'],
//   //       body: tmp['message'],
//   //       summary: tmp['groupe'],
//   //       largeIcon: tmp['image'],
//   //       roundedLargeIcon: true,
//   //       notificationLayout: NotificationLayout.Messaging,
//   //     ),
//   //     actionButtons: [
//   //       NotificationActionButton(
//   //           key: 'key',
//   //           label: Get.locale.toString().contains('en') ? 'ANSWER' : 'REPONDRE')
//   //     ]);


// }
