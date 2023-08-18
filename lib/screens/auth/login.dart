import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myskul/controllers/auth/login_controller.dart';
import 'package:myskul/screens/auth/password.dart';
import 'package:myskul/screens/auth/register.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:myskul/utilities/icons.dart';
import 'package:myskul/utilities/texts.dart';
import 'package:myskul/components/newButtonG.dart';
import 'package:myskul/components/newInput.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart';
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

  var hintText = "Adresse Email";

  var prefixIcon = Icon(Icons.person);

  var controller2 = TextEditingController();

  var onSubmit2 = (String a) {};

  var keyboardType2 = TextInputType.visiblePassword;

  var hintText2 = "Mot de passe";

  var prefixIcon2 = Icon(Icons.lock);

  bool isLoading = false;

  bool validEmail = true;
  bool validPassword = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final Future<SharedPreferences> _prefs2 = SharedPreferences.getInstance();

  void first() async {
    final SharedPreferences prefs = await _prefs;
    final SharedPreferences prefs2 = await _prefs2;
    bool? seen = await prefs2.getBool('first');
String? token = await prefs.getString('token');
    print(" first $seen  token $token ");
  }

  @override
  void initState() {
    // TODO: implement initState
    first();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                                "BIENVENUE",
                                style: GoogleFonts.getFont('Lato',
                                    textStyle: textes.h1l),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "SUR MySkul",
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
                              textes: textes,
                              couleurs: couleurs,
                              prefixIcon: prefixIcon),
                          NewInput(
                              obscureText: true,
                              controller: controller2,
                              onSubmit: onSubmit2,
                              keyboardType: keyboardType2,
                              hintText: hintText2,
                              textes: textes,
                              couleurs: couleurs,
                              prefixIcon: prefixIcon2),
                          NewButtonG(
                            textes: textes,
                            couleurs: couleurs,
                            icones: icones,
                            text: "SE CONNECTER",
                            function: () async {
                              if (controller.text.isEmpty) {
                                EasyLoading.showError("Email Requis");
                                validEmail = false;
                              } else if (controller2.text.isEmpty) {
                                EasyLoading.showError("Mot de passe Requis");
                                validPassword = false;
                              } else {
                                LoginController()
                                    .login(controller, controller2);
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
                                "Nouveau ?",
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
                                  " Creer un compte",
                                  style: textes.h4l
                                      .copyWith(color: couleurs.green),
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
                                "Mot de passe oublié ?",
                                style: textes.h4l,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(Password());
                                },
                                child: Text(
                                  " Récupérer mon mot de passe",
                                  style: textes.h4l
                                      .copyWith(color: couleurs.green),
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
      ),
    );
  }
}