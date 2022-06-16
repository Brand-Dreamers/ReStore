import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/account.dart';
import 'package:restore/screens/settings.dart';
import 'package:restore/components/pdf_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
            child: const Icon(
              Icons.menu,
              color: subtitleColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Restore",
              style: headerEmphasisTextStyle,
            ),
            CircularProfileAvatar(api + User.getUser().avatarURL + ext,
                radius: 15,
                backgroundColor: backgroundColor,
                cacheImage: true,
                elevation: 8.0,
                imageFit: BoxFit.fitHeight, onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Account()));
            }),
          ],
          
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PdfEditScreen())),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: buttonColor),
                    height: 100,
                    child: const Center(
                      child: Text("Stamp Document"),
                    ),
                  ),
                ),
              ]),
        )),
      ),
    );
  }
}
