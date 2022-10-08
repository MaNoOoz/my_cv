import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var page = 0.obs;
  var controller = PageController().obs;
  var fromController = ScrollController(initialScrollOffset: 0.0).obs;

  animateTo(int page) {
    if (controller.value.hasClients) {
      controller.value.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  resetController(int page) {
    controller.value = PageController(initialPage: page);
  }
}
