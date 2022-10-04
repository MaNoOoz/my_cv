import 'package:flutter/material.dart';

import '../app_config.dart';
import 'CustomTabBar.dart';

class TopNav extends StatelessWidget implements PreferredSizeWidget {
  int selectedIndex;
  final PageController? pageController;
  final Function? bottomTapped;

  TopNav({required this.selectedIndex, this.pageController, this.bottomTapped});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(bottom: 0.0),
      color: Colors.white,
      child: DefaultTabController(
        length: 3,
        initialIndex: selectedIndex,
        child: CustomTabBar(
          titles: Data.titels,
          selectedIndex: selectedIndex,
          onTap: (int index) {
            return bottomTapped!(index);
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
