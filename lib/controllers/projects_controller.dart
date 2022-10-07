import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:my_cv/app_config.dart';

class Projects_Controller extends GetxController {
  final _user_repos = [].obs;

  List<dynamic> get user_repos => _user_repos;

  late Worker _ever;

  Future<List<dynamic>> _getUserRepos() async {
    var url = "${Data.BASE_URL}/repos";
    var response = await http.get(Uri.parse(url), headers: Data.headersNoAuth);
    if (response.statusCode != 200) {
      return Future.error(response.statusCode);
    } else {
      var data = jsonDecode(response.body) as List;
      Logger().d("$data");

      _user_repos.clear();
      _user_repos.addAll(data);
      return data;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    Logger().d("onInit called");
    super.onInit();
    await _getUserRepos();
    _ever = ever(_user_repos, (_) => Logger().d("onInit() "));
  }
}
