import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:my_cv/app_config.dart';

class Projects_Controller extends GetxController {
  List<dynamic> _user_repos = [];

  List<dynamic> get user_repos => _user_repos;

  Future<List<dynamic>> getUserRepos() async {
    Logger().d("getUserRepos Called");

    var url = "${Data.BASE_URL}";

    try {
      var response =
          await http.get(Uri.parse("$url"), headers: Data.headersNoAuth);
      //   .timeout(
      // const Duration(seconds: 5),
      // onTimeout: () {
      //   // Time has run out, do what you wanted to do.
      //   return http.Response(
      //       'Error ', 403); // Request Timeout response status code
      // },
      // );

      _user_repos = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Logger().d("$data");
        return _user_repos;
      } else {
        Logger().d("Error in Response : ${response.reasonPhrase}");
        throw TimeoutException("Error :${response.reasonPhrase}");
      }
    } on TimeoutException catch (err) {
      throw TimeoutException(err.message);
    } catch (e) {
      print(e);
    }
    // update();

    return _user_repos;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _user_repos = await getUserRepos();
    // await getCommentsForUser(userId);
  }
}
