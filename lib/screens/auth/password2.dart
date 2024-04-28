import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myskul/controllers/auth/password_controller.dart';
import 'package:myskul/screens/auth/password.dart';
import 'package:myskul/screens/auth/register.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:myskul/utilities/icons.dart';
import 'package:myskul/utilities/texts.dart';
import 'package:myskul/components/button_g.dart';
import 'package:myskul/components/input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:myskul/screens/auth/reset.dart';


class Password2 extends StatelessWidget {
  var couleurs = ColorHelper();
  var textes = TextHelper();
  var icones = IconHelper();
  var controller = TextEditingController();
  var controller2 = TextEditingController();

  var onSubmit = (String a) {};
  var keyboardType = TextInputType.emailAddress;
  var hintText = "email";
  var prefixIcon = Icon(Icons.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: couleurs.white.withOpacity(0.5),
                  image: DecorationImage(
                      image: AssetImage("assets/images/math.png"),
                      opacity: 0.04,
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WidgetAnimator(
                    incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromTop(
                        duration: Duration(milliseconds: 500)),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "assets/images/wave-t.png",
                      ),
                    ),
                  ),
                  Container(),
                  WidgetAnimator(
                    incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(
                        duration: Duration(milliseconds: 500)),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        "assets/images/wave-b.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                        Image.asset(
                          "assets/images/logo2.png",
                          width: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "password-recov-title".tr,
                              style: GoogleFonts.getFont('Lato',
                                  textStyle: textes.h1l),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "password-recov-title2".tr,
                              style: GoogleFonts.getFont('Lato',
                                  textStyle: textes.h1l),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: 300,
                            child: Text(
                              "password-recov-text2".tr,
                              style: textes.h4l,
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        NewInput(
                            controller: controller,
                            onSubmit: onSubmit,
                            keyboardType: keyboardType,
                            hintText: hintText,
                            prefixIcon: prefixIcon),
                        SizedBox(
                          height: 5,
                        ),


                        NewInput(
                            controller: controller2,
                            onSubmit: onSubmit,
                            keyboardType: keyboardType,
                            hintText: "token ",
                            prefixIcon: prefixIcon),
                        SizedBox(
                          height: 5,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "".tr,
                              style: textes.h4l,
                            ),
                            GestureDetector(
                              onTap: () async{
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setBool('reset', false);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Password();
                                    }));
                              },
                              child: Text(
                                "token2".tr,
                                style: textes.h4l
                                    .copyWith(color: couleurs.green),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        NewButtonG(
                          text: "next",
                          function: () {
                            if (controller.text.isEmpty||controller2.text.isEmpty) {
                              EasyLoading.showError("no-input".tr);
                            } else {
                              Get.to(Reset(
                                  token: controller2.text,
                                  email: controller.text));
                              ;
                             // PasswordController().password(controller.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "new-here1".tr,
                              style: textes.h4l,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return Register();
                                    }));
                              },
                              child: Text(
                                "new-here2".tr,
                                style: textes.h4l
                                    .copyWith(color: couleurs.green),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
