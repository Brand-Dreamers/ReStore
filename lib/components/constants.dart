import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String baseURL = "https://restore-be.herokuapp.com/";
const String users = "users";
const String documentsEndpoint = "documents";
const String login = "signin";
const String register = "signup";

const backgroundColor = Color.fromARGB(255, 250, 255, 250);
const fieldColor = Color.fromARGB(50, 200, 200, 200);
const buttonColor = Color.fromARGB(255, 0, 158, 96);
const iconColor = Colors.black45;
const borderColor = Colors.black12;

TextStyle emphasizedHeader = GoogleFonts.poppins(
    fontWeight: FontWeight.w500, fontSize: 28, color: Colors.black);

TextStyle emphasizedSubheader = GoogleFonts.poppins(
    fontWeight: FontWeight.w300, fontSize: 14, color: Colors.black);

TextStyle buttonTextStyle = GoogleFonts.poppins()
    .copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);

const String api = "https://api.multiavatar.com/";
const String ext = ".png";

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

  DocumentInfo({this.title = "", this.size = "", this.data = ""});
}

class Popup extends StatelessWidget {
  final String message;
  final Widget icon;
  const Popup(
      {Key? key,
      this.message = "Please Wait",
      this.icon = const CircularProgressIndicator(color: buttonColor)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: size.width,
        height: 200,
        child: AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                height: 20,
              ),
              Text(
                message,
                style: emphasizedSubheader.copyWith(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
