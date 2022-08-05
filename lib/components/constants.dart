import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

const String baseURL = "https://restore-be.herokuapp.com";
const String usersEndpoint = "/users";
const String documentsEndpoint = "/documents";
const String profileEndpoint = "/profile";
const String login = "/signin";
const String register = "/signup";

const backgroundColor = Color.fromARGB(255, 250, 255, 250);
const fieldColor = Color.fromARGB(255, 235, 235, 235);
const buttonColor = Color.fromARGB(255, 0, 158, 96);

const headerColor = Colors.black54;
const subtitleColor = Colors.black38;
const iconColor = Colors.black45;
const borderColor = Colors.black12;
const lightTextColor = Colors.white;
const containerColor = Color.fromARGB(10, 10, 10, 0);
const errorColor = Color.fromARGB(255, 197, 20, 7);

TextStyle emphasizedHeader = GoogleFonts.poppins(
    fontWeight: FontWeight.w500, fontSize: 28, color: Colors.black);

TextStyle emphasizedSubheader = GoogleFonts.poppins(
    fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey);

TextStyle atUserTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: buttonColor);

TextStyle headerEmphasisTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: buttonColor);

TextStyle headerTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 36, color: headerColor);

TextStyle headerErrorTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 22, color: errorColor);

TextStyle littleHeaderTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 20, color: headerColor);

TextStyle subtitleTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.w300, fontSize: 20, color: subtitleColor);

TextStyle normalTextStyle =
    GoogleFonts.poppins().copyWith(fontSize: 36, color: headerColor);

TextStyle buttonTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, color: lightTextColor, fontSize: 16);

TextStyle iconButtonTextStyle =
    GoogleFonts.poppins().copyWith(color: buttonColor, fontSize: 16);

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

final List<String> documentFilter = [
  "Stamped",
  "Uploaded",
];

class Slide extends StatelessWidget {
  final String slideImageURL;
  final String topHeaderText;
  final String bottomHeaderText;
  final String description;

  const Slide(
      {Key? key,
      required this.slideImageURL,
      required this.topHeaderText,
      required this.bottomHeaderText,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topHeaderText,
            style: emphasizedHeader,
          ),
          Text(
            bottomHeaderText,
            style: emphasizedHeader,
          ),
          const SizedBox(height: 5),
          Text(description, style: emphasizedSubheader),
          const SizedBox(
            height: 50,
          ),
          Center(child: Image.asset(slideImageURL)),
        ],
      ),
    );
  }
}

List<Slide> startSlides = [
  const Slide(
    topHeaderText: "Easy",
    bottomHeaderText: "Document Stamping",
    description: "With Restore, you can stamp your documents online with ease",
    slideImageURL: "assets/images/start 1.png",
  ),
  const Slide(
    topHeaderText: "Save",
    bottomHeaderText: "Your Time",
    description:
        "Manage your time by saving yourself the stress of manual stamping",
    slideImageURL: "assets/images/start 2.png",
  ),
  const Slide(
    topHeaderText: "Upload",
    bottomHeaderText: "Your Documents",
    description: "Save and upload your documents for later use",
    slideImageURL: "assets/images/start 3.png",
  ),
];

class Wait extends StatelessWidget {
  final String message;
  const Wait({Key? key, this.message = "Please Wait"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 150,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: buttonColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: subtitleTextStyle,
          ),
        ],
      ),
    );
  }
}

class BlankScreen extends StatelessWidget {
  const BlankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Wait()),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  final String message;
  final String imageURL;

  const NotificationContainer(
      {Key? key, required this.message, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            imageURL,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: subtitleTextStyle,
          ),
        ],
      ),
    );
  }
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
