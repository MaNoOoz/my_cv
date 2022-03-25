import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_cv/app_config.dart';

class Projects_Controller extends GetxController {
   List<dynamic> user_repos = [];

  Future<List<dynamic>> getUserRepos() async {
    var url = "${Data.BASE_URL}";

    var response =
        await http.get(Uri.parse("$url"), headers: Data.headersNoAuth);
    if (response.statusCode != 200) {
      return Future.error(response.statusCode);
    } else {
      var data = jsonDecode(response.body) as List;
      user_repos.clear();
      user_repos.addAll(data);
      return data;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserRepos();
  }
}
