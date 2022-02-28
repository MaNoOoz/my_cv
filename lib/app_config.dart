import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Data {
  static String BASE_URL = "https://api.github.com/users/manoooz/repos";
  static Map<String, String> headersNoAuth = {
    'Content-Type': 'text/plain',
    "Accept": "application/json"
  };

  static int mobileScreenW = 760;

  static final HEADLINE1 = GoogleFonts.oswald(
    textStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.pinkAccent,
      height: 1.5,
    ),
  );
  static final HEADLINE2 = GoogleFonts.monoton(
    textStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
  );
  static final TITLE3 = GoogleFonts.tajawal(
    textStyle: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: Colors.pink,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final TITLE2 = GoogleFonts.montserratAlternates(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: Colors.black54,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final SUBTITLE3 = GoogleFonts.montserratAlternates(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final SMALL = GoogleFonts.montserratAlternates(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final SMALL2 = GoogleFonts.montserratAlternates(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.black54,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final SMALL1 = GoogleFonts.montserratAlternates(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.black26,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final SMALL3 = GoogleFonts.montserratAlternates(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Colors.black45,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );

  static final List<IconData> navIcons = const [
    Icons.home,
    // Icons.ondemand_video,
    Icons.add,
    Icons.add,
    // MdiIcons.bellOutline,
    Icons.menu,
  ];
  static final List<String> titels = const [
    "Profile",
    // Icons.ondemand_video,
    "Projects",
    "Skills",
    // MdiIcons.bellOutline,
    "Social",
  ];
}
