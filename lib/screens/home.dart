import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myskul/controllers/chat_controller.dart';
import 'package:myskul/controllers/quiz_controller.dart';
import 'package:myskul/models/user.dart';
import 'package:myskul/screens/chat/chat_group_list.dart';
import 'package:myskul/screens/drawer.dart';
import 'package:myskul/screens/quiz/category_list.dart';
import 'package:myskul/screens/quiz/leaderboard.dart';
import 'package:myskul/screens/shop/product_list_page.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:myskul/utilities/constants.dart';
import 'package:myskul/utilities/gradients.dart';
import 'package:myskul/utilities/icons.dart';
import 'package:myskul/utilities/texts.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ChatGPT/chatgpt.dart';
import 'fitness/fitness.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var user;

  getUser() async {
    final prefs = await _prefs;
    var userString = await prefs.getString('user');
    var userJson = jsonDecode(userString!);
    user = User.fromJson(userJson);
    if (user.speciality['speciality']
        .toString()
        .toLowerCase()
        .contains('toe')) {
           ChatController().addUser(user, Constant().PTOE);
    } else if (user.speciality['speciality']
        .toString()
        .toLowerCase()
        .contains('tcf')) {
          ChatController().addUser(user, Constant().PTCL);
    } else if (user.speciality['speciality']
        .toString()
        .toLowerCase()
        .contains('phar')) {
          ChatController().addUser(user, Constant().PH);
    } else if (user.speciality['speciality']
        .toString()
        .toLowerCase()
        .contains('dent')) {
          ChatController().addUser(user, Constant().MD);
    } else if (user.speciality['speciality']
        .toString()
        .toLowerCase()
        .contains('gen')) {
          ChatController().addUser(user, Constant().MG);
    } else if (user.speciality['speciality']
        .toString()
        .toLowerCase()
        .contains('ide')) {
          ChatController().addUser(user, Constant().PIDE);
    } else {
      ChatController().addUser(user, Constant().PMD);
    }
    return user;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> images = [
    "phone.jpg",
    "image1.png",
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: ColorHelper().green,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return HomepageScaffold(
                scaffoldKey: scaffoldKey, user: snapshot.data!);
          }
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: ColorHelper().green,
            ),
          ),
        );
      },
      future: getUser(),
    );
  }
}

class HomepageScaffold extends StatefulWidget {
  HomepageScaffold({required this.scaffoldKey, required this.user});

  final GlobalKey<ScaffoldState> scaffoldKey;
  var user;

  @override
  State<HomepageScaffold> createState() => _HomepageScaffoldState();
}

class _HomepageScaffoldState extends State<HomepageScaffold> {
  late Map<String, dynamic> scores;

  Future<Map<String, dynamic>> getScore() async {
    scores = await QuizController().getAllScores();
    return scores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      drawer: MainDrawer(
        user: widget.user,
        subMenuKey: widget.scaffoldKey,
      ),
      endDrawer: EndDrawer(
        subMenuKey: widget.scaffoldKey,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorHelper().green,
          onRefresh: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                              if (widget
                                  .scaffoldKey.currentState!.isDrawerOpen) {
                                widget.scaffoldKey.currentState!.closeDrawer();
                                //close drawer, if drawer is open
                              } else {
                                widget.scaffoldKey.currentState!.openDrawer();
                                //open drawer, if drawer is closed
                              }
                            },
                            child: Icon(
                              IconHelper().menu,
                              color: ColorHelper().green,
                              size: 30,
                            ),
                          ),
                          Image.asset(
                            "assets/images/logo2.png",
                            width: 35,
                          ),
                          Bounceable(
                            onTap: () {
                              if (widget
                                  .scaffoldKey.currentState!.isEndDrawerOpen) {
                                widget.scaffoldKey.currentState!
                                    .closeEndDrawer();
                                //close drawer, if drawer is open
                              } else {
                                widget.scaffoldKey.currentState!
                                    .openEndDrawer();
                                //open drawer, if drawer is closed
                              }
                            },
                            child: Icon(
                              IconHelper().notif,
                              color: ColorHelper().green,
                              size: 30,
                            ),
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
                                  image: AssetImage("assets/images/1.jpeg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/2.jpeg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/3.jpeg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/4.jpeg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/5.jpeg"),
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
                    //       BoxDecoration(gradient: GradientHelper().greenGradient),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nEtiam semper lacinia nunc . ",
                    //         style: TextHelper().h4l.copyWith(color: ColorHelper().white),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: GradientHelper().greenGradient),
                      child: ListView(children: [
                        CarouselSlider(
                          items: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: GradientHelper().greenGradient),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Pourquoi tant de souffrances ? alors que MYSKUL est là",
                                    style: TextHelper()
                                        .h4l
                                        .copyWith(color: ColorHelper().white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: GradientHelper().greenGradient),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "J'ai téléchargé MYSKUL et toi ?",
                                    style: TextHelper()
                                        .h4l
                                        .copyWith(color: ColorHelper().white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: GradientHelper().greenGradient),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Prépares ton examen dès maintenant grâce \nà l'application MYSKUL",
                                    style: TextHelper()
                                        .h4l
                                        .copyWith(color: ColorHelper().white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: GradientHelper().greenGradient),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "GATEWAY SMART",
                                    style: TextHelper()
                                        .h4l
                                        .copyWith(color: ColorHelper().white),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: GradientHelper().greenGradient),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "La préparation aux examens de médécine \ndevient une partie de plaisir",
                                    style: TextHelper()
                                        .h4l
                                        .copyWith(color: ColorHelper().white),
                                    textAlign: TextAlign.center,
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
                                style: TextHelper()
                                    .h3l
                                    .copyWith(color: ColorHelper().grey),
                              ),
                              SizedBox(
                                height: 05,
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
                                icone: IconHelper().quiz,
                                texte: "My Quiz",
                                couleur: Colors.blue,
                                function: () {
                                  Get.to(() => CategorList(user: widget.user));
                                },
                              ),
                              DashBox(
                                icone: IconHelper().shop,
                                texte: "My Shop ",
                                couleur: Colors.black26,
                                function: () {
                                  Get.to(() => ProductListPage());
                                },
                              ),
                              DashBox(
                                icone: IconHelper().chat,
                                texte: "My Chat",
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
                                icone: IconHelper().leader,
                                texte: "Leaderboard",
                                couleur: ColorHelper().lemon,
                                function: () {
                                  Get.to(() => LeaderBoard(user: widget.user));
                                },
                              ),
                             /* DashBox(
                                icone: IconHelper().shop,
                                texte: "My AI",
                                couleur: ColorHelper().lightGreen,
                                function: () {
                                  Get.to(() => GPT(
                                        user: widget.user,
                                      ));
                                },
                              ),
                              DashBox(
                                icone: IconHelper().fitness,
                                texte: "My Fitness",
                                couleur: Colors.red,
                                function: () {
                                  Get.to(() => Fitness());
                                },
                              ),*/
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
                                style: TextHelper()
                                    .h3l
                                    .copyWith(color: ColorHelper().grey),
                              ),
                              SizedBox(
                                height: 05,
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.05,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: ColorHelper().green),
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
                                          Text(
                                            widget.user.domain.length > 0
                                                ? widget.user.domain[0]
                                                    ['display_name']
                                                : ' ',
                                            style: TextHelper().h2l.copyWith(
                                                color: ColorHelper().green),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.user.speciality != null
                                                ? widget
                                                    .user.speciality['sigle']
                                                : ' ',
                                            style: TextHelper().h4b.copyWith(
                                                color: ColorHelper().green),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.user.school != null
                                                ? widget
                                                    .user.school['display_name']
                                                : ' ',
                                            style: TextHelper().h4b.copyWith(
                                                color: ColorHelper().green),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            widget.user.level != null
                                                ? widget.user.level['level']
                                                : ' ',
                                            style: TextHelper().h4l.copyWith(
                                                color: ColorHelper().green),
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
                                style: TextHelper()
                                    .h3l
                                    .copyWith(color: ColorHelper().grey),
                              ),
                              SizedBox(
                                height: 05,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: FutureBuilder(
                              builder: (ctx,
                                  AsyncSnapshot<Map<String, dynamic>>
                                      snapshot) {
                                // Checking if future is resolved or not
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  // If we got an error
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );

                                    // if we got our data
                                  } else if (snapshot.hasData) {
                                    // Extracting data from snapshot object
                                    final data =
                                        snapshot.data as Map<String, dynamic>;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(data["quiz"].toString(),
                                                    style: TextHelper().h3b),
                                                Text("t-quiz".tr,
                                                    style: TextHelper().h4l),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(data["correct"].toString(),
                                                    style: TextHelper().h3b),
                                                Text("r".tr,
                                                    style: TextHelper().h4l),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 110,
                                          width: 1,
                                          color: ColorHelper()
                                              .grey
                                              .withOpacity(0.1),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              "score".tr,
                                              style: TextHelper().h3r.copyWith(
                                                  color: ColorHelper().green),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(data["score"].toString(),
                                                style: TextHelper()
                                                    .xxlb
                                                    .copyWith(
                                                        color: ColorHelper()
                                                            .green)),
                                          ],
                                        ),
                                        Container(
                                          height: 110,
                                          width: 1,
                                          color: ColorHelper()
                                              .grey
                                              .withOpacity(0.1),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    data["questions"]
                                                        .toString(),
                                                    style: TextHelper().h3b),
                                                Text("t-question".tr,
                                                    style: TextHelper().h4l),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(data["wrong"].toString(),
                                                    style: TextHelper().h3b),
                                                Text("t".tr,
                                                    style: TextHelper().h4l),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
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
                              future: getScore(),
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
      ),
    );
  }
}

class DashBox extends StatelessWidget {
  DashBox({
    required this.icone,
    required this.texte,
    required this.couleur,
    this.function,
  });

  final IconData icone;
  final String texte;
  final Color couleur;
  void Function()? function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3.3, //110,
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
                    color: ColorHelper().white.withOpacity(0.5),
                  ),
                  child: Icon(
                    icone,
                    color: ColorHelper().white,
                    size: 20,
                  ),
                ),
                Text(
                  texte,
                  style: TextHelper()
                      .h4b
                      .copyWith(color: ColorHelper().white.withOpacity(0.8)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
