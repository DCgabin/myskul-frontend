import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myskul/components/messages_tiles.dart';
import 'package:myskul/controllers/chat_controller.dart';
import 'package:myskul/models/user.dart';
import 'package:myskul/utilities/constants.dart';
import '../../utilities/colors.dart';
import '../../utilities/gradients.dart';
import '../../utilities/icons.dart';
import '../../utilities/texts.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class GPT extends StatefulWidget {
  GPT({required this.user});
  User user;
  @override
  State<GPT> createState() => _GPTState();
}

class _GPTState extends State<GPT> {
  StreamSubscription? sus;

  List messages = [];

  var couleurs = ColorHelper();

  var textes = TextHelper();

  var icones = IconHelper();

  var gradients = GradientHelper();

  var messageController = TextEditingController();

  final ScrollController controller = ScrollController();

  void scrollDown(ScrollController ctrl) async {
    if (ctrl.positions.isNotEmpty && ctrl.position.hasContentDimensions) {
      await ctrl.animateTo(ctrl.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // @override
  // void initState() {
  //   TODO: implement initState
  //   super.initState();

  // }

  // @override
  // void dispose() {
  //   TODO: implement dispose
  //   super.dispose();
  //   sus!.cancel();
  // }

  sendRequest(String msg) async {
    print(">>>>>>>>>>>>>>>>>");
    final openAI =  OpenAI.instance.build(
        token: Constant().MS,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 20)),
        enableLog: true);

    // final request =
    //     CompleteText(prompt: msg, maxTokens: 200, model: TextDavinci3Model());

    final request = ChatCompleteText(messages: [
      Messages(role: Role.user, content: msg),
      Messages(role: Role.system, content: 'Act as if your name is MyAI'),
    ], maxToken: 200, model: GptTurboChatModel());

    try {
      // final response = await openAI!.onCompletion(request: request);
      // print('AI response ' + response!.choices[0].text);
      var text = " ";
      final response = await openAI.onChatCompletion(request: request);
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      print("réponse "+response.toString());
      for (var element in response!.choices) {
        text += " ${element.message?.content}";
        print("data -> ${element.message?.content}");
      }

      var tmp = {
        'message': text,
        'sender': 'chatGPT',
        'senderImage':
            'https://ww2.freelogovectors.net/svg16/chatgpt-logo-freelogovectors.net.svg',
        'type': 'bot',
        'time': DateTime.now().microsecondsSinceEpoch.toString(),
      };
      messages.add(tmp);
    } catch (e) {
      print("errorrrrrrr>>>>>>>>>>>>>>>>>>>><<");
      print(e);
      var tmp = {
        'message': 'ai-error'.tr,
        'sender': 'chatGPT',
        'type': 'bot',
        'time': DateTime.now().microsecondsSinceEpoch.toString(),
      };

      messages.add(tmp);
    }

    ChatController().playLocalAudio("bubble.wav");

    setState(() {});

    scrollDown(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(bottom: 80),
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
              child: messages.isEmpty
                  ? SingleChildScrollView(
                      child: NotFoundAiWidget(texte: 'ai-bot'.tr))
                  : ListView.builder(
                      controller: controller,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          scrollDown(controller);
                          return Container(
                            height: 100,
                          );
                        }

                        if (index == 0) {
                          SizedBox(
                            height:
                                (MediaQuery.of(context).size.height / 10) + 10,
                          );
                        }

                        if (messages[index]['type'] == 'user') {
                          return SentAiMessage(
                            texte: messages[index]['message'],
                            image: messages[index]['senderImage'],
                            nom: messages[index]['sender'],
                          );
                        } else {
                          return ReceivedAiMessage(
                            texte: messages[index]['message'],
                          );
                        }
                      })),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).padding.top +
                  (MediaQuery.of(context).size.height / 12),
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
                                  // Get.back();

                                  showDialogBox();
                                },
                                child: Icon(
                                  icones.back2,
                                  color: couleurs.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "My AI",
                            style: textes.h2l.copyWith(color: couleurs.white),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                  color: couleurs.green,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.send,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: couleurs.white,
                  decoration: InputDecoration(
                    hintText: "ask-question".tr,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (value) {
                    if (messageController.text != '') {
                      var tmp = {
                        'message': messageController.text,
                        'sender': widget.user.username,
                        'senderImage': widget.user.profile_image,
                        'type': 'user',
                        'time':
                            DateTime.now().microsecondsSinceEpoch.toString(),
                      };

                      messages.add(tmp);
                      ChatController().playLocalAudio("long-pop.wav");
                      setState(() {});
                      sendRequest(messageController.text);
                      messageController.clear();
                      scrollDown(controller);
                    } else {
                      scrollDown(controller);
                    }
                  },
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    if (messageController.text != '') {
                      var tmp = {
                        'message': messageController.text,
                        'sender': widget.user.username,
                        'senderImage': widget.user.profile_image,
                        'type': 'user',
                        'time':
                            DateTime.now().microsecondsSinceEpoch.toString(),
                      };

                      messages.add(tmp);
                      ChatController().playLocalAudio("long-pop.wav");
                      setState(() {});
                      sendRequest(messageController.text);
                      messageController.clear();
                      scrollDown(controller);
                    } else {
                      scrollDown(controller);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: couleurs.green,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

showDialogBox() {
  showDialog(
      context: Get.context as BuildContext,
      builder: (context) => CupertinoAlertDialog(
            title: Text('warning'.tr),
            content: Text('ai-warning'.tr),
            actions: [
              CupertinoButton.filled(
                  borderRadius: BorderRadius.zero,
                  child: Text('yes'.tr),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.back();
                  })
            ],
          ));
}
