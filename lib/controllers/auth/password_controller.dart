import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myskul/screens/auth/login.dart';
import 'package:myskul/screens/auth/password2.dart';
import 'package:myskul/utilities/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PasswordController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void password(emailController) async {
    try {
      var headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json"
      };
      var url = Uri.parse(
          ApiEndponits().baseUrl + ApiEndponits().authEndpoints.password);
      Map body = {
        "email": emailController,
      };

      EasyLoading.show();

      http.Response res = await http.post(url,
          body: jsonEncode(body), headers: headers);

      EasyLoading.dismiss();

      if (res.statusCode == 200) {
        // Initialisation du package SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var json = jsonDecode(res.body);
        EasyLoading.showSuccess(json["message"]);
        await prefs.setBool('reset', true);
        Get.off(Password2());
      } else {
        throw jsonDecode(res.body)['message'] ?? "unknown-error".tr;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  void reset( String email,  String password, String passwordConfirm,
       String token) async {
    try {
      var headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json"
      };
      var url = Uri.parse(
          ApiEndponits().baseUrl + ApiEndponits().authEndpoints.resetPassword);
      Map body = {
        "password": password,
        "password_confirmation": passwordConfirm,
        "email": email,
        "token": token,
      };

      EasyLoading.show();

      http.Response res = await http.post(url,
          body: jsonEncode(body), headers: headers);

      EasyLoading.dismiss();

      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        EasyLoading.showSuccess(json['message']);
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('reset', false);

        Get.off(Login());
      } else {
        throw jsonDecode(res.body)['message'] ?? "unknown-error".tr;
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
