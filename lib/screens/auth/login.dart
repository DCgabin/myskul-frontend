import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myskul/controllers/auth/login_controller.dart';
import 'package:myskul/screens/auth/password.dart';
import 'package:myskul/screens/auth/password2.dart';
import 'package:myskul/screens/auth/register.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:myskul/utilities/icons.dart';
import 'package:myskul/utilities/texts.dart';
import 'package:myskul/components/button_g.dart';
import 'package:myskul/components/input.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var couleurs = ColorHelper();

  var textes = TextHelper();

  var icones = IconHelper();

  var controller = TextEditingController();

  var onSubmit = (String a) {};

  var keyboardType = TextInputType.emailAddress;

  var hintText = "email";

  var prefixIcon = Icon(Icons.person);

  var controller2 = TextEditingController();

  var onSubmit2 = (String a) {};

  var keyboardType2 = TextInputType.visiblePassword;

  var hintText2 = "password";

  var prefixIcon2 = Icon(Icons.lock);

  bool isLoading = false;

  bool obscureText = true;

  bool validEmail = true;
  bool validPassword = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Future<SharedPreferences> _prefs2 = SharedPreferences.getInstance();

  void first() async {
    final SharedPreferences prefs = await _prefs;
    final SharedPreferences prefs2 = await _prefs2;
    bool? seen = await prefs2.getBool('first');
    String? token = await prefs.getString('token');
    bool? reset = await prefs2.getBool('first');
  }

  @override
  void initState() {
    // TODO: implement initState
    first();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.1,
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
                              "welcome".tr,
                              style: GoogleFonts.getFont('Lato',
                                  textStyle: textes.h1l),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "welcome2".tr,
                              style: GoogleFonts.getFont('Lato',
                                  textStyle: textes.h1l),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        NewInput(
                            controller: controller,
                            onSubmit: onSubmit,
                            keyboardType: keyboardType,
                            hintText: hintText,
                            prefixIcon: prefixIcon),
                        NewInput(
                          obscureText: obscureText,
                          controller: controller2,
                          onSubmit: onSubmit2,
                          keyboardType: keyboardType2,
                          hintText: hintText2,
                          prefixIcon: prefixIcon2,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                            child: obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                        ),
                        NewButtonG(
                          text: "connect",
                          function: () async {
                            if (controller.text.isEmpty) {
                              EasyLoading.showError("no-input".tr);
                            } else if (controller2.text.isEmpty) {
                              EasyLoading.showError("no-input".tr);
                            } else {
                              LoginController()
                                  .login(controller.text, controller2.text);
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
                                style:
                                    textes.h4l.copyWith(color: couleurs.green),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "forgot-password1".tr,
                              style: textes.h4l,
                            ),
                            GestureDetector(
                              onTap: () async{
                                final SharedPreferences prefs2 = await _prefs2;
                                bool? reset = await prefs2.getBool('reset');
                                reset==null?reset=false:true;

                                print("valeur de rst");
                                print(reset);
                                if(reset)
                                  Get.to(Password2());
                                else
                                  Get.to(Password());
                              },
                              child: Text(
                                "forgot-password2".tr,
                                style:
                                    textes.h4l.copyWith(color: couleurs.green),
                              ),
                            )
                          ],
                        )
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
