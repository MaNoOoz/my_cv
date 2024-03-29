import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../app_config.dart';
import '../controllers/homeController.dart';

class CustomTabBar extends StatelessWidget {
  // final List<IconData> icons;
  final List<String> titles;
  final int? selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;

  CustomTabBar(
    this.titles, {
    Key? key,
    // required this.icons,
    required this.selectedIndex,
    required this.onTap,
    this.isBottomIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());
    Logger().d("main_controller.page.value : ${mainController.page.value}");
    Logger().d("selectedIndex $selectedIndex");
    // var icons1 = icons
    //     .asMap()
    //     .map((key, value) => MapEntry(
    //         key,
    //         Icon(
    //           value,
    //           color: Colors.red,
    //         )))
    //     .values
    //     .toList();
    var titles1 = titles
        .asMap()
        .map((i, e) => MapEntry(
              i,
              Tab(
                child: Text(
                  e,
                  style: Data.SM2,
                ),
              ),
            ))
        .values
        .toList();
    // Map map = Map.fromIterables(icons, titles1);
    // print("${map}");

    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.black54,
      indicatorPadding: EdgeInsets.zero,
      enableFeedback: true,
      indicatorColor: Colors.red,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.pink.shade200, width: 3.0, style: BorderStyle.solid),
        ),
      ),
      tabs: titles1,
      onTap: onTap,
    );
  }
}
