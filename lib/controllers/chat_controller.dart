import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myskul/components/messages_tiles.dart';
import 'package:myskul/models/user.dart';
import 'package:myskul/utilities/api_endpoints.dart';
import 'package:myskul/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:myskul/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:collection/collection.dart";

import 'auth/registration_controller.dart';

class ChatController {
  static final db = FirebaseFirestore.instance;
  static final fMessaging = FirebaseMessaging.instance;

  final CollectionReference groups = db.collection("groupes");
  final CollectionReference messages = db.collection("messages");
  final CollectionReference tokens = db.collection("tokens");

// Une fonction pour recuprer les données des groupes sur firestore
  Future<List<Map<String, dynamic>>> getGroups() async {
    Map tmp;
    List<Map<String, dynamic>> list = [];
    groups.get().then((value) {
      for (var doc in value.docs) {
        list.add(doc.data() as Map<String, dynamic>);
      }
    });

    return list;
  }

// Une fonction pour avoir les infos d'un groupe

  Future<Map<String, dynamic>> getGroup(String document) async {
    Map<String, dynamic> tmp = {};
    groups.doc(document).get().then((value) {
      tmp = value.data() as Map<String, dynamic>;
    }).onError((error, stackTrace) => null);

    return tmp;
  }

// Une fonction pour ajouter un utilisateur dans un groupe

  void addUser(User user, String document) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final fmToken = await prefs.getString('fmToken');

    Map userTmp = {
      'userId': user.id,
      'userName': user.username,
      'userPic': user.profile_image,
    };
    groups
        .doc(document)
        .update({
          'members': FieldValue.arrayUnion([userTmp])
        })
        .then((value) => print("DocumentSnapshot successfully updated!"))
        .onError((e, stackTrace) =>
            print("Error updating document ${user.email} $e"));
  }

  // Une fonction pour ajouter le fcm token d'un  utilisateur dans un groupe

  void addUserPushToken(User user, String document) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final fmToken = await prefs.getString('fmToken');

    Map<Object, Object?> userTmp = {
      'userId': user.id,
      'userPushToken': fmToken,
    };

    EasyLoading.show();

    tokens
        .doc(document)
        .update({
          'users': FieldValue.arrayUnion([userTmp])
        })
        .then((value) => print("DocumentSnapshot successfully updated!"))
        .onError((e, stackTrace) =>
            print("Error updating document ${user.email} $e"));
    await prefs.setBool('notif', true);
    EasyLoading.dismiss();
  }

// Raccourci pour ajouter tous les groups sur firestore

  void addAllGroups() async {
    List tmp = [
      {
        'groupName': 'Médecine dentaire',
        'groupPic':
            'https://ui-avatars.com/api/?name=M+D&color=226520&background=E3FFE3',
        'members': '',
        'recentMessage': '',
        'recentMessageSender': '',
        'recentMessageTime': '',
      },
      {
        'groupName': 'Médecine générale',
        'groupPic':
            'https://ui-avatars.com/api/?name=M+G&color=226520&background=E3FFE3',
        'members': '',
        'recentMessage': '',
        'recentMessageSender': '',
        'recentMessageTime': '',
      },
      {
        'groupName': 'Pharmacie',
        'groupPic':
            'https://ui-avatars.com/api/?name=P+H&color=226520&background=E3FFE3',
        'members': '',
        'recentMessage': '',
        'recentMessageSender': '',
        'recentMessageTime': '',
      },
      {
        'groupName': 'Prepa Médecine',
        'groupPic':
            'https://ui-avatars.com/api/?name=P+M&color=226520&background=E3FFE3',
        'members': '',
        'recentMessage': '',
        'recentMessageSender': '',
        'recentMessageTime': '',
      },
      {
        'groupName': 'Prepa IDE',
        'groupPic':
            'https://ui-avatars.com/api/?name=P+I&color=226520&background=E3FFE3',
        'members': '',
        'recentMessage': '',
        'recentMessageSender': '',
        'recentMessageTime': '',
      },
      {
        'groupName': 'Prepa TCL',
        'groupPic':
            'https://ui-avatars.com/api/?name=T+C&color=226520&background=E3FFE3',
        'members': '',
        'recentMessage': '',
        'recentMessageSender': '',
        'recentMessageTime': '',
      },
      {
        'groupName': 'Prepa TOEI/TOEFL',
        'groupPic':
            'https://ui-avatars.com/api/?name=P+T&color=226520&background=E3FFE3',
        'members': '',
        'recentMessage': '',
        'recentMessageSender': '',
        'recentMessageTime': '',
      },
    ];
    for (var element in tmp) {
      groups.add(element);
    }
  }

// Une fonction pour enlever un utilisateur d'un groupe

  void removeUser(User user, String document) async {
    Map userTmp = {
      'userId': user.id,
      'userName': user.username,
      'userPic': user.profile_image,
    };
    groups
        .doc(document)
        .update({
          'members': FieldValue.arrayRemove([userTmp])
        })
        .then((value) => print("DocumentSnapshot successfully updated!"))
        .onError((e, stackTrace) => print("Error updating document $e"));
  }

  // Une fonction pour enlever le token d' un utilisateur d'un groupe

  void removeUserPushNotification(User user, String document) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final fmToken = await prefs.getString('fmToken');

    Map<Object, Object?> userTmp = {
      'userId': user.id,
      'userPushToken': fmToken,
    };

    EasyLoading.show();

    tokens
        .doc(document)
        .update({
          'users': FieldValue.arrayRemove([userTmp])
        })
        .then((value) => print("DocumentSnapshot successfully updated!"))
        .onError((e, stackTrace) => print("Error updating document $e"));
    await prefs.setBool('notif', false);
    EasyLoading.dismiss();
  }

  // Une fonction pour enlever le token d' un utilisateur d'un groupe

  Future<bool> checkUserPushNotification(User user, String document) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final fmToken = await prefs.getString('fmToken');
    List list = [];

    Map<Object, Object?> userTmp = {
      'userId': user.id,
      'userPushToken': fmToken,
    };

    await tokens.doc(Constant().TOKEN).get().then((value) {
      var tmp = value.data()! as Map;

      for (var docSnapshot in tmp['users']) {
        if (docSnapshot['userId'] == user.id) {
          list.add(docSnapshot);
        }
      }
    });

    return list.isEmpty ? false : true;
  }

// Scroll automatique

  void scrollDown(ScrollController ctrl) async {
    if (ctrl.positions.isNotEmpty && ctrl.position.hasContentDimensions) {
      final position = ctrl.position.maxScrollExtent; 
       ctrl.jumpTo(position);
    }
  }

  // Play sound

  playLocalAudio(String music) async {
    final player = AudioPlayer();
    await player.play(AssetSource('sons/$music'));
  }

  chatMessages({chats, user, couleurs, textes, controller}) {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("error found");
          return NotFoundWidget(texte: "Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(height: (MediaQuery.of(context).size.height / 2.5)),
              Center(
                child: CircularProgressIndicator(
                  color: couleurs.green,
                ),
              ),
            ],
          );
        }

        Map<String, List> grouped =
            groupBy<dynamic, String>(snapshot.data.docs, (chat) {
          DateTime time =
              DateTime.fromMicrosecondsSinceEpoch(int.parse(chat['time']));
          return " ${time.day} - ${time.month} - ${time.year} ";
        });

        return snapshot.data.docs.length > 0
            ? SingleChildScrollView(
                controller: controller,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: grouped.keys.length,
                    itemBuilder: (context, index) {
                      String date = grouped.keys.toList()[index];

                      var messages = grouped[date];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              date,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.3),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: messages!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == messages.length) {
                                scrollDown(controller);
                                return Container(
                                  height: 80,
                                );
                              }
                              if (index == 0) {
                                SizedBox(
                                  height: (MediaQuery.of(context).size.height /
                                          10) +
                                      10,
                                );
                              }
                              var tmp = messages[index].data() as Map;
                              if (tmp['type'] == 'texte') {
                                if (tmp['sender'] == user.username) {
                                  return SentMessage(
                                    texte: tmp['message'],
                                    image: tmp['senderImage'],
                                    nom: tmp['sender'],
                                    time: tmp['time'],
                                  );
                                }

                                return ReceivedMessage(
                                  texte: tmp['message'],
                                  image: tmp['senderImage'],
                                  nom: tmp['sender'] ?? ' ',
                                  time: tmp['time'],
                                );
                              } else {
                                if (tmp['sender'] == (user.username)) {
                                  return SentImage(
                                    tmp: tmp,
                                    user: user,
                                  );
                                }

                                return ReceivedImage(
                                  tmp: tmp,
                                );
                              }
                            },
                          )
                        ],
                      );
                    }),
              )
            : SingleChildScrollView(
                child: NotFoundWidget(texte: 'not-found-message'.tr),
              );
      },
    );
  }

// envoyer un message

  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var groupUsers;
    var tokenUsers;
    User user;

    var userString = await prefs.getString('user');

    var userJson = jsonDecode(userString!);
    user = User.fromJson(userJson);

    messages.add(chatMessageData);
    groups.doc(groupId).update({
      "recentMessage": chatMessageData['type'] == 'texte'
          ? chatMessageData['message']
          : '📷',
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
    playLocalAudio("long-pop.wav");
    await groups.where("groupId", isEqualTo: groupId).get().then((value) {
      groupUsers = value;
    });

    var u = groupUsers.docs[0].data() as Map;

    await tokens.get().then((value) {
      tokenUsers = value;
    });

    var v = tokenUsers.docs[0].data() as Map;

    for (var i in u['members']) {
      for (var element in v['users']) {
        if (element['userId'] == i['userId'] && user.id != i['userId']) {
          if (element['userPushToken'] != null &&
              element['userPushToken'] != "") {
            sendPushNotification(
                element['userPushToken'],
                u['groupName'],
                u['groupPic'],
                chatMessageData['sender'],
                chatMessageData['type'] == 'texte'
                    ? chatMessageData['message']
                    : '📷');
          }
        }
      }
    }
  }

// pour avoir le Token Firebase messagessing d'un device

  Future<String> getFmToken() async {
    String? tmp;
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var token = await prefs.getString('token');
    await fMessaging.requestPermission();
    await fMessaging.getToken().then((value) {
      if (value != null) {
        print(value);
        tmp = value;
        RegisterationController().updateToken(fcm_token: value, token: token);
      } else {
        tmp = '';
      }
    });

    return tmp!;
  }
}

// envoyer des notifications firebase

Future<void> sendPushNotification(String fmToken, String group, String image,
    String user, String message) async {
  try {
    var headers = {
      "Authorization":
          "key=AAAA_rCxGWA:APA91bFarlSM4Sg24gkGf-RLtsK_SpFgSzcNBkxucTJWHMhsR15BHlNGSdqjwhio8psmauqFwTEwjkjnJ0cXrJv4MQpg4zZJKIplHHiM8tLP9RhlcD_PXxyBLmexwTC4HsVGV_v_tdXZ",
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    Map body = {
      "to": fmToken,
      "data": {
        "groupe": group,
        "image": image,
        "nom": '~ ' + user.capitalizeFirst!,
        "message": message,
        "type": "chat"
      },
    };

    var url = Uri.parse(ApiEndponits().sendPushNotificationUrl);

    http.Response res = await http.post(url,
        body: utf8.encode(jsonEncode(body)), headers: headers);

    if (res.statusCode == 200) {
      print("notification sent successfully");
    } else {
      throw jsonDecode(res.body)['message'] ?? "unknown-error".tr;
    }
  } catch (e) {
    print(e);
  }
}

class ShowImage extends StatelessWidget {
  ShowImage({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ColorHelper().black,
      child: Image.network(image),
    ));
  }
}
