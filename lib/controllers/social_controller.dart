import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Social_Controller extends GetxController {
  var height = 160.0;
  var width = 160.0;
  var shape = BoxShape.circle;

  void changeShape() {
    if (shape == BoxShape.rectangle) {
      shape = BoxShape.circle;
    } else {
      shape = BoxShape.rectangle;
    }
    update();
  }

  openMap() async {
    const url =
        'https://www.google.com/maps/search/?api=1&query=48.8566,2.3522';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  linkedinURL(String $profileName) async {
    var url = "https://www.linkedin.com/in/yaman-alkhateb/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  twitterURL(String $profileName) async {
    var url = 'https://twitter.com/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  googleplayURL(String $profileName) async {
    var url = 'https://play.google.com/store/apps/dev?id=' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  youtubeURL(String $profileName) async {
    var url = 'https://www.youtube.com/channel/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  githubURL(String $profileName) async {
    var url = 'https://github.com/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  telegramURL(String $profileName) async {
    var url = 'https://t.me/' + $profileName;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
