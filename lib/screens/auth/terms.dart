import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myskul/components/gender_box.dart';
import 'package:myskul/components/input_number.dart';
import 'package:myskul/controllers/auth/registration_controller.dart';
import 'package:myskul/controllers/chat_controller.dart';
import 'package:myskul/main.dart';
import 'package:myskul/models/user.dart';
import 'package:myskul/screens/account/account_password.dart';
import 'package:myskul/screens/auth/login.dart';
import 'package:myskul/screens/auth/terms.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:myskul/utilities/gradients.dart';
import 'package:myskul/utilities/icons.dart';
import 'package:myskul/utilities/texts.dart';
import 'package:myskul/components/button_g.dart';
import 'package:myskul/components/input.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Term extends StatefulWidget {
  @override
  State<Term> createState() => _TermState();
}

class _TermState extends State<Term> {
  var couleurs = ColorHelper();

  var textes = TextHelper();

  var icones = IconHelper();

  var gradients = GradientHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 2,
              margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height / 12),
              ),
              decoration: BoxDecoration(
                color: couleurs.white.withOpacity(0.5),
                image: DecorationImage(
                    image: AssetImage("assets/images/math.png"),
                    opacity: 0.04,
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'What is Lorem Ipsum?',
                        style: textes.h2b,
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                            textAlign: TextAlign.justify,
                            style: textes.h4l.copyWith(height: 2),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'What is Lorem Ipsum?',
                        style: textes.h2b,
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                            textAlign: TextAlign.justify,
                            style: textes.h4l.copyWith(height: 2),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 12,
                decoration: BoxDecoration(
                    gradient: gradients.greenGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: CircleAvatar(
                          backgroundColor: couleurs.white.withOpacity(0.05),
                          radius: 20,
                        )),
                    Positioned(
                        top: 50,
                        right: 40,
                        child: CircleAvatar(
                          backgroundColor: couleurs.white.withOpacity(0.05),
                          radius: 08,
                        )),
                    Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        right: 40,
                        child: CircleAvatar(
                          backgroundColor: couleurs.white.withOpacity(0.05),
                          radius: 15,
                        )),
                    Positioned(
                        top: MediaQuery.of(context).size.height / 5,
                        left: 40,
                        child: CircleAvatar(
                          backgroundColor: couleurs.white.withOpacity(0.05),
                          radius: 25,
                        )),
                    Positioned(
                        top: 0,
                        left: MediaQuery.of(context).size.width / 1.5,
                        child: CircleAvatar(
                          backgroundColor: couleurs.white.withOpacity(0.05),
                          radius: 28,
                        )),
                    Positioned(
                        top: 40,
                        left: 40,
                        child: CircleAvatar(
                          backgroundColor: couleurs.white.withOpacity(0.05),
                          radius: 08,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    icones.back2,
                                    color: couleurs.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'terms'.tr,
                              style: textes.h3l.copyWith(color: couleurs.white),
                            ),
                            SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
