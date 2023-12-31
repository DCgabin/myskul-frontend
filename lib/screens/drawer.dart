import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:myskul/controllers/auth/login_controller.dart';
import 'package:myskul/controllers/notification_controller.dart';
import 'package:myskul/models/notif.dart' as n;
import 'package:myskul/models/user.dart';
import 'package:myskul/screens/account/account.dart';
// import 'package:myskul/screens/history/history.dart';
import 'package:myskul/screens/partner.dart';
import 'package:myskul/screens/subscriptions/subscriptions.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:myskul/utilities/icons.dart';
import 'package:myskul/utilities/texts.dart';
import 'package:myskul/utilities/gradients.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

import 'library/library.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({required this.user, required this.subMenuKey});
  final User user;
  final couleurs = ColorHelper();

  final textes = TextHelper();

  final icones = IconHelper();

  final gradients = GradientHelper();

  final String _url = ('https://wa.me/237656451666');

  final Future<SharedPreferences> _prefs2 = SharedPreferences.getInstance();
  final GlobalKey subMenuKey;

  Future<void> _launchUrl() async {
    if (!await launch(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: couleurs.white.withOpacity(0.1),
                              radius: 08,
                            )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: couleurs.white.withOpacity(0.1),
                              radius: 15,
                            )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: couleurs.white.withOpacity(0.1),
                              radius: 15,
                            )),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/loading1.gif'),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(user.profile_image),
                            ),
                          ),
                          SizedBox()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Bounceable(
                            onTap: () {
                              showAlertDialog2(context);
                            },
                            child: Icon(
                              icones.logout,
                              color: couleurs.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Text(
                              user.name,
                              style: textes.h3b.copyWith(color: couleurs.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox()
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: gradients.greenGradient,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10)),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    icones.account,
                    color: couleurs.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("my-account".tr),
                ],
              ),
              onTap: () {
                Get.to(() => Account(user: user));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    icones.library,
                    color: couleurs.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('my-lib'.tr),
                ],
              ),
              tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
              onTap: () {
                Get.to(() => LibraryPage());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    icones.subscription,
                    color: couleurs.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('my-sub'.tr),
                ],
              ),
              tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
              onTap: () {
                Get.to(() => Subscriptions());
              },
            ),
            // ListTile(
            //   title: Row(
            //     children: [
            //       Icon(
            //         icones.history,
            //         color: couleurs.green,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text('history'.tr),
            //     ],
            //   ),
            //   tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            //   onTap: () {
            //     Get.to(() => History());
            //   },
            // ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    icones.partner,
                    color: couleurs.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('our-part'.tr),
                ],
              ),
              onTap: () {
                Get.to(() => Partner());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    icones.help,
                    color: couleurs.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('sav'.tr),
                ],
              ),
              onTap: _launchUrl,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Bounceable(
                  onTap: () async {
                    Get.updateLocale(Locale("fr"));
                    final SharedPreferences prefs = await _prefs2;
                    await prefs.setString('locale', "fr");
                    print(Get.locale);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/fr.png",
                        width: 20,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: 20,
                        height: 5,
                        color: Get.locale.toString().contains("fr")
                            ? couleurs.green
                            : couleurs.white,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: couleurs.black.withOpacity(0.1),
                ),
                Bounceable(
                  onTap: () async {
                    Get.updateLocale(Locale("en"));
                    final SharedPreferences prefs = await _prefs2;
                    await prefs.setString('locale', "en");
                    print(Get.locale);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/en.png",
                        width: 25,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        width: 20,
                        height: 5,
                        color: Get.locale.toString().contains("en")
                            ? couleurs.green
                            : couleurs.white,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EndDrawer extends StatelessWidget {
  EndDrawer({required this.subMenuKey});

  final couleurs = ColorHelper();

  final textes = TextHelper();

  final icones = IconHelper();

  final gradients = GradientHelper();

  var notifs;

  final Future<SharedPreferences> _prefs2 = SharedPreferences.getInstance();
  final GlobalKey subMenuKey;

  Future<List<n.Notification>> getNotif() async {
    notifs = await NotificationController().getAllNotification();
    print("notifs ${notifs}");
    return notifs;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor:
                                    couleurs.white.withOpacity(0.1),
                                radius: 08,
                              )),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor:
                                    couleurs.white.withOpacity(0.1),
                                radius: 15,
                              )),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor:
                                    couleurs.white.withOpacity(0.1),
                                radius: 15,
                              )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(),
                        Text(
                          'NOTIFICATIONS',
                          style: textes.h3b.copyWith(color: couleurs.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        PopupMenuButton(
                            padding: EdgeInsets.only(bottom: 10),
                            icon: Icon(
                              Icons.more_vert,
                              color: ColorHelper().white,
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Text("as-read".tr.toLowerCase()),
                                ),
                              ];
                            },
                            onSelected: (value) {
                              if (value == 1) {
                                NotificationController().readAllNotification();
                              }
                            }),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: gradients.greenGradient,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                builder: (ctx, AsyncSnapshot<List<n.Notification>> snapshot) {
                  // Checking if future is resolved or not
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                          style: TextHelper().bodyTextl,
                          textAlign: TextAlign.center,
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      final data = snapshot.data;
                      
                      return data != null && data.length >= 1
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: data[index].isRead == 1
                                              ? ColorHelper().green
                                              : Colors.transparent)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].dateDeCreation),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data[index].contenu,
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        height: 05,
                                      ),
                                      Divider(
                                        color: Colors.black26,
                                      )
                                    ],
                                  ),
                                );
                              })
                          : Center(
                              child: Text(
                                'not-found'.tr,
                                style: TextHelper().bodyTextl,
                                textAlign: TextAlign.center,
                              ),
                            );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },

                // Future that needs to be resolved
                // inorder to display something on the Canvas
                future: getNotif(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

showAlertDialog2(BuildContext context) {
  // show the dialog
  showDialog(
      context: Get.context as BuildContext,
      builder: (context) => CupertinoAlertDialog(
            title: Text("warning".tr, style: TextHelper().h1r),
            content: Text("warning-text".tr, style: TextHelper().h4l),
            actions: [
              CupertinoButton.filled(
                  borderRadius: BorderRadius.zero,
                  child: Text("yes".tr),
                  onPressed: () {
                    LoginController().logout();
                  }),
            ],
          ));
}
