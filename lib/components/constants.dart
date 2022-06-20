import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

const backgroundColor = Color.fromARGB(255, 250, 255, 250);
const fieldColor = Colors.transparent;
const buttonColor = Color.fromARGB(255, 26, 133, 105);
const headerColor = Colors.black54;
const subtitleColor = Colors.black38;
const iconColor = Colors.black45;
const borderColor = Colors.black12;
const lightTextColor = Colors.white;

TextStyle headerEmphasisTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: buttonColor);

TextStyle headerTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 36, color: headerColor);

TextStyle littleHeaderTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: headerColor);

TextStyle subtitleTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.w300, fontSize: 20, color: subtitleColor);

TextStyle normalTextStyle =
    GoogleFonts.poppins().copyWith(fontSize: 36, color: headerColor);

TextStyle buttonTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, color: lightTextColor, fontSize: 16);

final List<String> colleges = [
  "COLAMRUD",
  "COLANIM",
  "COLBIOS",
  "COLENG",
  "COLERM",
  "COLFHEC",
  "COLMAS",
  "COLPHYS",
  "COLPLANT",
  "COLVET"
];

final List<String> levels = ["100", "200", "300", "400", "500"];

List<String> getDepartments(String? collegeName) {
  if (collegeName == "COLAMRUD") {
    return ["AGAD", "AEFM", "AERD", "CGS"];
  }

  if (collegeName == "COLANIM") {
    return ["ABG", "ANN", "APH", "ANP", "PRM"];
  }

  if (collegeName == "COLBIOS") {
    return ["BCH", "MCB", "PAB", "PAZ"];
  }

  if (collegeName == "COLENG") {
    return ["ABE", "CVE", "ELE", "MCE", "MTE"];
  }

  if (collegeName == "COLERM") {
    return ["AQFM", "EMT", "FWM", "WRMA"];
  }

  if (collegeName == "COLFHEC") {
    return ["FST", "HSM", "HOT", "NTD"];
  }

  if (collegeName == "COLMAS") {
    return ["BAF", "BZA", "ECN", "ENS"];
  }

  if (collegeName == "COLPHYS") {
    return ["CHM", "CSC", "MTS", "PHS", "STS"];
  }

  if (collegeName == "COLPLANT") {
    return ["CPP", "HRT", "PBST", "PPCP", "SSLM"];
  }

  if (collegeName == "COLVET") {
    return ["VTA", "VPHR", "VMS", "VMP", "VTP", "VPP", "VPT"];
  }

  return [];
}

const String api = "https://api.multiavatar.com/";
const String ext = ".png";

String getRandomCharacters(int length) {
  const characters = 'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
}

List<String> getAvatarURLS(int numberOfUrls) {
  List<String> avatarURLS = [];
  for (var i = 0; i < numberOfUrls; i++) {
    avatarURLS.add(getRandomCharacters(10));
  }
  return avatarURLS;
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;
  bool get isDarkMode => mode == ThemeMode.dark;
}

class RestoreThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 250, 255, 250),
    colorScheme: const ColorScheme.light(),
  );
}


/**
 * Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.bottomCenter, end: Alignment.center,
            colors: [Colors.black, Colors.transparent]).createShader(rect),
            blendMode: BlendMode.darken,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
              ))
          ),
        ),
 */