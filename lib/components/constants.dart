import 'package:flutter/material.dart';
import 'dart:math';

const String baseURL = "https://restore-be.herokuapp.com/";
const String users = "users";
const String documentsEndpoint = "documents";
const String login = "/signin";
const String register = "/signup";

const backgroundColor = Color.fromARGB(255, 230, 230, 230);
const fieldColor = Color.fromARGB(50, 200, 200, 200);
const buttonColor = Color.fromARGB(255, 0, 158, 96);
const iconColor = Colors.black45;
const borderColor = Colors.black12;

const emphasizedHeader = TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.w500,
    fontSize: 28,
    color: Colors.black);

const emphasizedSubheader = TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: Colors.black);

const buttonTextStyle = TextStyle(
    fontFamily: "Poppins",
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.white);

const double stampImageSize = 150.0;

const String api = "https://api.multiavatar.com/";
const String ext = ".png";

const String success = "SUCCESS";

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

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme: const ColorScheme.dark(),
);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 250, 255, 250),
  colorScheme: const ColorScheme.light(),
);

class DocumentInfo {
  String title;
  String size;
  String data;
  String id;

  DocumentInfo({this.title = "", this.size = "", this.data = "", this.id = ""});
}

class Popup extends StatefulWidget {
  final String message;
  final Widget icon;

  const Popup(
      {Key? key,
      this.message = "Please Wait",
      this.icon = const CircularProgressIndicator(color: buttonColor)})
      : super(key: key);

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: size.width * 0.75,
        child: AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.message,
                style: emphasizedSubheader.copyWith(
                    fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
