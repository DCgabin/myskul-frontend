import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myskul/models/sub-type.dart';
import 'package:myskul/models/subscription.dart';
import 'package:myskul/main.dart';
import 'package:myskul/screens/subscriptions/subscriptions.dart';
import 'package:myskul/utilities/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SubscriptionController {
  static Future<List<Subscription>> getAll() async {
    token = await (await SharedPreferences.getInstance()).getString('token');
    var headers = {
      "Authorization": "Bearer" + " " + token.toString(),
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    var url = Uri.parse(
        ApiEndponits().baseUrl + ApiEndponits().endpoints.subscription);

    http.Response res = await http.get(url, headers: headers);
    final json = jsonDecode(res.body);
    return (json['data']['subscriptions'] as List)
        .map((e) => Subscription.fromJson(e))
        .toList();
  }

  static Future<List<SubscriptionType>> getSubTypes() async {
    token = await (await SharedPreferences.getInstance()).getString('token');
    var headers = {
      "Authorization": "Bearer" + " " + token.toString(),
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    var url = Uri.parse(
        ApiEndponits().baseUrl + ApiEndponits().endpoints.subscriptionTypes);

    http.Response res = await http.get(url, headers: headers);
    final json = jsonDecode(res.body);
    return (json['data']['subscriptions'] as List)
        .map((e) => SubscriptionType.fromJson(e))
        .toList();
  }

  static Future<Subscription> getById(String id) async {
    token = await (await SharedPreferences.getInstance()).getString('token');
    var headers = {
      "Authorization": "Bearer" + " " + token.toString(),
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    var url = Uri.parse(
        ApiEndponits().baseUrl + ApiEndponits().endpoints.subscription + id);

    http.Response res = await http.get(url, headers: headers);
    final json = jsonDecode(res.body);
    return Subscription.fromJson(json['data']['subscription']);
  }

  static Future<bool> create(Subscription subscription) async {
    token = await (await SharedPreferences.getInstance()).getString('token');
    var headers = {
      "Authorization": "Bearer" + " " + token.toString(),
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
    };

    var url = Uri.parse(
        ApiEndponits().baseUrl + ApiEndponits().endpoints.subscription);

   /* var url = Uri.parse(
        ApiEndponits().baseUrl + "/payment/status/98196576");*/

    Map<String, String?> data = subscription.toJson();

    EasyLoading.show();

   /* http.Response res =
    await http.post(url, headers: headers, body: jsonEncode(data));

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+token.toString());
    print(res);

    EasyLoading.dismiss();*/

     try {
      http.Response res =
          await http.post(url, headers: headers, body: jsonEncode(data));
      EasyLoading.dismiss();
      if (res.statusCode == 200) {
        print("Success");
        return true;
      } else {
        EasyLoading.showInfo("${json.decode(res.body)}");
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showInfo("$e");
      return false;
    }
    return false;
  }
}
