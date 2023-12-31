import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myskul/controllers/quiz_controller.dart';

import '../../components/messages_tiles.dart';
import '../../models/category.dart';
import '../../models/user.dart';
import '../../utilities/colors.dart';
import '../../utilities/gradients.dart';
import '../../utilities/icons.dart';
import '../../utilities/texts.dart';
import 'category.dart';

class CategorList extends StatefulWidget {
  CategorList({required this.user, this.name});
  User user;
  String? name;
  @override
  State<CategorList> createState() => _CategorListState();
}

class _CategorListState extends State<CategorList> {
  var controller = TextEditingController();

  var couleurs = ColorHelper();

  var textes = TextHelper();

  var icones = IconHelper();

  var gradients = GradientHelper();

  var categories;

  List<Widget> displaycategories(List<Category> CategorList) {
    List<CategoryWidget> w = [];
    CategorList.forEach((element) {
      w.add(CategoryWidget(category: element));
    });
    return w;
  }

  getCategories() {
    categories = QuizController().getCategories(widget.name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).padding.top +
                      MediaQuery.of(context).size.height / 12,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 30,
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
                                'category'.tr,
                                style:
                                    textes.h2l.copyWith(color: couleurs.white),
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
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    color: couleurs.white.withOpacity(0.5),
                    image: DecorationImage(
                        image: AssetImage("assets/images/math.png"),
                        opacity: 0.04,
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        TextField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.send,
                          cursorColor: ColorHelper().black,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: couleurs.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Icons.search,
                              color: couleurs.black,
                            ),
                            hintText: "search".tr,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onSubmitted: (v) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CategorList(
                                          user: widget.user,
                                          name: v,
                                        )));
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            "quiz-text".tr,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              FutureBuilder(
                                future: categories,
                                builder: (context, snapshot) {
                                  try {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                           List tmp = snapshot.data as List;
                                      return tmp.isNotEmpty
                                          ? Column(
                                              children: displaycategories(
                                                  snapshot.data
                                                      as List<Category>),
                                            )
                                          : Center(
                                              child: Text(
                                              'not-found'.tr,
                                              style: textes.h3r,
                                              textAlign: TextAlign.center,
                                            ));
                                    } else if (snapshot.hasError) {
                                      return NotFoundWidget(
                                          texte: 'not-found'.tr);
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: couleurs.green,
                                        ),
                                      ); // Display the fetched data
                                    }
                                  } catch (e) {
                                    return Center(
                                        child: Text(
                                      e.toString(),
                                      style: textes.h3r,
                                    ));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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
