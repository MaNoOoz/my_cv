import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:my_cv/controllers/social_controller.dart';
import 'package:my_cv/widgets/SharedWidgets.dart';
import 'package:my_cv/widgets/bottomNav.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'app_config.dart';
import 'controllers/homeController.dart';
import 'controllers/projects_controller.dart';
import 'controllers/skills_controller.dart';

void main() {
  // runApp(DevicePreview(enabled: true, builder: (c) => MyApp()));
  runApp(const MyApp());
}

final MainController main_controller = Get.put(MainController());
final Projects_Controller projects_controller = Get.put(Projects_Controller());
final Skill_Controller skill_controller = Get.put(Skill_Controller());
final Social_Controller social_controller = Get.put(Social_Controller());

class MobileView extends StatelessWidget {
  Widget mPageView() {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     projects_controller.user_repos.clear();
      //     projects_controller.onInit();
      //   },
      // ),
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
          style: Data.H2,
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade300,
      ),
      body: PageView(
        controller: main_controller.controller.value,
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        children: [
          SharedWidgets.projects_page(projects_controller),
          // Container(),
          SharedWidgets.skils_page(skill_controller),
          SharedWidgets.social_page2(social_controller),
        ],
        onPageChanged: (value) {
          main_controller.page.value = value;
          // main_controller.onPageChanged(value);
          // if (value == 2) {
          //   Social_Controller().getUserInfo();
          // }
          Logger().d("onPageChanged $value");
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

// class Web extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Row(
//       children: [
//         Expanded(flex: 1, child: SharedWidgets.projects_page(projects_controller)),
//         Expanded(flex: 1, child: SharedWidgets.skils_page(skill_controller)),
//         Expanded(flex: 1, child: SharedWidgets.social_page(social_controller)),
//       ],
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var deviceType = getDeviceType(MediaQuery.of(context).size);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My CV',
      home: Scaffold(
          body: ScreenTypeLayout(
        breakpoints: const ScreenBreakpoints(
          tablet: 600,
          desktop: 700,
          watch: 300,
        ),
        desktop: Container(
            // color: Colors.blue,
            // child: Web(),
            ),
        mobile: Container(
          // color: Colors.red,
          child: MobileView(),
        ),
      )),
    );
  }
}
