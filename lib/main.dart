import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cv/widgets/SharedWidgets.dart';
import 'package:my_cv/widgets/bottomNav.dart';

import 'app_config.dart';
import 'controllers/homeController.dart';
import 'controllers/projects_controller.dart';
import 'controllers/skills_controller.dart';

void main() {
  runApp(MyApp());
}

final MainController main_controller = Get.put(MainController());
final Projects_Controller projects_controller = Get.put(Projects_Controller());
final Skill_Controller skill_controller = Get.put(Skill_Controller());

class MobileView extends GetView {
  Widget mPageView() {
    return Scaffold(
      appBar: AppBar(
        bottom: TopNav(
            pageController: main_controller.controller.value,
            selectedIndex: main_controller.page.value,
            bottomTapped: (i) {
              main_controller.animateTo(i);
            }),
        // bottomTapped: (i) => ),
        title: Text(
          "My CV",
          style: Data.HEADLINE2,
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade300,
      ),
      body: PageView(
        controller: main_controller.controller.value,
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        children: [
          SharedWidgets.profile_page(projects_controller),
          SharedWidgets.projects_page(projects_controller),
          SharedWidgets.skils_page(skill_controller),
          SharedWidgets.social_page(),
        ],
        onPageChanged: (value) {
          main_controller.page.value = value;
          // main_controller.onPageChanged(value);
          print("onPageChanged: $value");
          // print("onPageChanged: ${main_controller.onPageChanged(value)}");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return mPageView();
  }
}

class Web extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(
            flex: 1, child: SharedWidgets.profile_page(projects_controller)),
        Expanded(
            flex: 1, child: SharedWidgets.projects_page(projects_controller)),
        Expanded(flex: 2, child: SharedWidgets.skils_page(skill_controller)),
        Expanded(flex: 1, child: SharedWidgets.social_page()),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My CV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveLayout(
        web: Web(),
        mobile: MobileView(),
      ),
    );
  }
}

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key, required this.mobile, required this.web})
      : super(key: key);

  final Widget mobile;
  final Widget web;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    // var screenWidth =  MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= Data.mobileScreenW) {
          return widget.mobile;
        }
        return widget.web;
      },
    );
  }
}
