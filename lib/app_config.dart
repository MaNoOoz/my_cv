import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Data {
  static String BASE_URL = "https://api.github.com/users/manoooz";
  static Map<String, String> headersNoAuth = {'Content-Type': 'text/plain', "Accept": "application/json"};

  static double WEB_LAYOUT = 500;

  static final H1 = GoogleFonts.oswald(
    textStyle: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.pinkAccent,
      height: 1.5,
    ),
  );
  static final H2 = GoogleFonts.monoton(
    textStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
  );
  static final T1 = GoogleFonts.dmSans(
    textStyle: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: Colors.black87,
      // height: 1.5,
      // wordSpacing: 1,
      // letterSpacing: 1,
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final T2 = GoogleFonts.montserratAlternates(
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
  static final S1 = GoogleFonts.montserratAlternates(
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
  static final SM1 = GoogleFonts.montserratAlternates(
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
  static final SM2 = GoogleFonts.montserratAlternates(
    textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
        height: 1.5,
        wordSpacing: 1,
        letterSpacing: 1,
        overflow: TextOverflow.ellipsis
        // decoration: TextDecoration.lineThrough,
        ),
  );
  static final O1 = GoogleFonts.cabin(
    textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
        height: 1.5,
        wordSpacing: 1,
        letterSpacing: 1,
        overflow: TextOverflow.ellipsis
        // decoration: TextDecoration.lineThrough,
        ),
  );
  static final O2 = GoogleFonts.cabin(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.black87,
      height: 1.5,
      wordSpacing: 1,
      letterSpacing: 1,
      // overflow: TextOverflow.clip
      // decoration: TextDecoration.lineThrough,
    ),
  );
  static final SM3 = GoogleFonts.montserratAlternates(
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
  static final SM4 = GoogleFonts.montserratAlternates(
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

  static const List<IconData> navIcons = [
    Icons.home,
    // Icons.ondemand_video,
    Icons.add,
    Icons.add,
    // MdiIcons.bellOutline,
    Icons.menu,
  ];
  static const List<String> titels = [
    "Projects",
    "Skills",
    "Social",
  ];
}
