import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myskul/controllers/chat_controller.dart';
import 'package:myskul/models/user.dart';
import 'package:myskul/screens/chat/chat_group_list.dart';
import 'package:myskul/screens/drawer.dart';
import 'package:myskul/screens/quiz/quiz.dart';
import 'package:myskul/screens/quiz/quiz_list.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:myskul/utilities/constants.dart';
import 'package:myskul/utilities/icons.dart';
import 'package:myskul/utilities/texts.dart';
import 'package:myskul/utilities/gradients.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myskul/controllers/home_controller.dart';

class Home extends StatefulWidget {
  Home({required this.user});
  User user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var couleurs = ColorHelper();

  var textes = TextHelper();

  var icones = IconHelper();

  var gradients = GradientHelper();

  List<String> images = [
    "phone.jpg",
    "image1.png",
  ];

  getUser() async {
    final SharedPreferences prefs = await _prefs;

    var userString = await prefs.getString('user');
    var userJson = jsonDecode(userString!);
    widget.user = User.fromJson(userJson);
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.user.email}");
    return Scaffold(
      key: scaffoldKey,
      drawer: MainDrawer(user: widget.user),
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 500),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Bounceable(
                          onTap: () {
                            if (scaffoldKey.currentState!.isDrawerOpen) {
                              scaffoldKey.currentState!.closeDrawer();
                              //close drawer, if drawer is open
                            } else {
                              scaffoldKey.currentState!.openDrawer();
                              //open drawer, if drawer is closed
                            }
                          },
                          child: Icon(
                            icones.menu,
                            color: couleurs.green,
                            size: 30,
                          ),
                        ),
                        Image.asset(
                          "assets/images/logo2.png",
                          width: 35,
                        ),
                        Icon(
                          icones.notif,
                          color: couleurs.green,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: ListView(children: [
                      CarouselSlider(
                        items: [
                          Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/image1.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/phone.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/image1.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          height: 300.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 10,
                          enableInfiniteScroll: true,
                          viewportFraction: 1.2,
                        ),
                      ),
                    ]),
                  ),
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration:
                  //       BoxDecoration(gradient: gradients.greenGradient),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nEtiam semper lacinia nunc . ",
                  //         style: textes.h4l.copyWith(color: couleurs.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration:
                        BoxDecoration(gradient: gradients.greenGradient),
                    child: ListView(children: [
                      CarouselSlider(
                        items: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: gradients.greenGradient),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nEtiam semper lacinia nunc . ",
                                  style: textes.h4l
                                      .copyWith(color: couleurs.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: gradients.greenGradient),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nEtiam semper lacinia nunc . ",
                                  style: textes.h4l
                                      .copyWith(color: couleurs.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: gradients.greenGradient),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nEtiam semper lacinia nunc . ",
                                  style: textes.h4l
                                      .copyWith(color: couleurs.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          height: 50.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 10,
                          enableInfiniteScroll: true,
                          viewportFraction: 1.2,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "dash".tr,
                              style: textes.h3l.copyWith(color: couleurs.grey),
                            ),
                            SizedBox(
                              height: 05,
                            ),
                            Container(
                              height: 1,
                              width: 100,
                              margin: EdgeInsets.only(left: 4),
                              color: couleurs.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashBox(
                              couleurs: couleurs,
                              icone: icones.quiz,
                              textes: textes,
                              texte: "Quiz",
                              couleur: Colors.blue,
                              function: () {
                                Get.to(() => QuizList(user: widget.user));
                              },
                            ),
                            DashBox(
                              couleurs: couleurs,
                              icone: icones.shop,
                              textes: textes,
                              texte: "Shop",
                              couleur: Colors.black26,
                            ),
                            DashBox(
                              couleurs: couleurs,
                              icone: icones.chat,
                              textes: textes,
                              texte: "Chat",
                              couleur: Colors.pink,
                              function: () {
                                Get.to(() => GroupChat(user: widget.user));
                              },
                            ),
                            SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DashBox(
                              couleurs: couleurs,
                              icone: icones.leader,
                              textes: textes,
                              texte: "Leaderboard",
                              couleur: couleurs.lemon,
                            ),
                            DashBox(
                              couleurs: couleurs,
                              icone: icones.shop,
                              textes: textes,
                              texte: "ChatGPT",
                              couleur: couleurs.lightGreen,
                            ),
                            DashBox(
                              couleurs: couleurs,
                              icone: icones.fitness,
                              textes: textes,
                              texte: "Fitness",
                              couleur: Colors.red,
                            ),
                            SizedBox()
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "current-plan".tr,
                              style: textes.h3l.copyWith(color: couleurs.grey),
                            ),
                            SizedBox(
                              height: 05,
                            ),
                            Container(
                              height: 1,
                              width: 100,
                              margin: EdgeInsets.only(left: 4),
                              color: couleurs.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Bounceable(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 1.05,
                                height: 200,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: couleurs.green),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Image.asset(
                                          "assets/images/arc-01.png",
                                          width: 250,
                                        )),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "BORDS NUMERIQUES",
                                              style: textes.h4l.copyWith(
                                                  color: couleurs.green),
                                            ),
                                            SizedBox(
                                              height: 05,
                                            ),
                                            Container(
                                              height: 1,
                                              width: 70,
                                              margin: EdgeInsets.only(left: 4),
                                              color: couleurs.green,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "FMSB YAOUNDE",
                                          style: textes.h4b
                                              .copyWith(color: couleurs.green),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "NIVEAU 1",
                                          style: textes.h4l
                                              .copyWith(color: couleurs.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Image.asset(
                                        "assets/images/learning.png",
                                        width: 250,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "user-info".tr,
                              style: textes.h3l.copyWith(color: couleurs.grey),
                            ),
                            SizedBox(
                              height: 05,
                            ),
                            Container(
                              height: 1,
                              width: 110,
                              margin: EdgeInsets.only(left: 4),
                              color: couleurs.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("15", style: textes.h3b),
                                      Text("t-quiz".tr, style: textes.h4l),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("15", style: textes.h3b),
                                      Text("r".tr, style: textes.h4l),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 110,
                                width: 1,
                                color: couleurs.grey.withOpacity(0.1),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "score".tr,
                                    style: textes.h3r
                                        .copyWith(color: couleurs.green),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("150",
                                      style: textes.xxlb
                                          .copyWith(color: couleurs.green)),
                                ],
                              ),
                              Container(
                                height: 110,
                                width: 1,
                                color: couleurs.grey.withOpacity(0.1),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("200", style: textes.h3b),
                                      Text("t-question".tr, style: textes.h4l),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("15", style: textes.h3b),
                                      Text("t".tr, style: textes.h4l),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashBox extends StatelessWidget {
  DashBox({
    super.key,
    required this.couleurs,
    required this.icone,
    required this.texte,
    required this.couleur,
    required this.textes,
    this.function,
  });

  final ColorHelper couleurs;
  final IconData icone;
  final TextHelper textes;
  final String texte;
  final Color couleur;
  void Function()? function;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: function,
      child: SizedBox(
        width: 110,
        height: 100,
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(10),
          color: couleur.withOpacity(0.5),
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: couleurs.white.withOpacity(0.5),
                  ),
                  child: Icon(
                    icone,
                    color: couleurs.white,
                    size: 20,
                  ),
                ),
                Text(
                  texte,
                  style: textes.h4b
                      .copyWith(color: couleurs.white.withOpacity(0.8)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
