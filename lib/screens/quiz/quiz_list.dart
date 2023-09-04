import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myskul/controllers/quiz_controller.dart';

import '../../components/messagesTile.dart';
import '../../models/quiz.dart';
import '../../models/user.dart';
import '../../utilities/colors.dart';
import '../../utilities/gradients.dart';
import '../../utilities/icons.dart';
import '../../utilities/texts.dart';
import 'quiz.dart';

class QuizList extends StatefulWidget {
  QuizList({required this.user});
  User user;
  @override
  State<QuizList> createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {
  var couleurs = ColorHelper();

  var textes = TextHelper();

  var icones = IconHelper();

  var gradients = GradientHelper();

  var quizzes;

  List<Widget> displayQuizzes(List<QuizModel> quizList) {
    List<QuizWidget> w = [];
    for (var i = 0; i < quizList.length; i++) {
      print(quizList[i].toJson());
      w.add(QuizWidget(quiz: quizList[i]));
    }
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: BackButton(),
            backgroundColor: Color.fromRGBO(34, 152, 127, 1),
            expandedHeight: 80,
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Text("Quiz"),
              ),
              background: Stack(
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
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 28,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0x3abec4c3),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "ENTREZ UN MOT CLE",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Faites des quiz et apprenez plus rapidement !",
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
                          future: QuizController().getQuizzes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return NotFoundWidget(
                                  textes: textes,
                                  couleurs: couleurs,
                                  texte: 'Not Found');
                            } else {
                              return Column(
                                children: displayQuizzes(snapshot.data as List<QuizModel>),
                              );
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
        ],
      ),
    );
  }
}
