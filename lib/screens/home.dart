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

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerHeight = size.height * 0.3;
    double imageSize = containerHeight * 0.6;
    double leftOffset = containerHeight - 80;
    double topOffset = containerHeight - 100;
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
            GestureDetector(
              onTap: () {
                setState(() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Account())));
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(api + User.getUser().avatarURL + ext),
                radius: 15.0,
                backgroundColor: Colors.transparent,
              ),
            ),
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
                  height: 20,
                ),
                Text(
                  "Welcome, " + User.getUser().surname,
                  style: littleHeaderTextStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "What would you like to do today?",
                  style: subtitleTextStyle,
                ),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 2.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PdfHandler()));
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(5.0)),
                            height: containerHeight,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/stamp.png",
                                  height: imageSize,
                                  width: imageSize,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "Stamp",
                                    style: littleHeaderTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: leftOffset,
                      top: topOffset,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 2.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              height: containerHeight,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/upload.png",
                                    height: imageSize,
                                    width: imageSize,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Upload",
                                      style: littleHeaderTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: topOffset * 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 2.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: containerColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              height: containerHeight,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/document.png",
                                    height: imageSize,
                                    width: imageSize,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Documents",
                                      style: littleHeaderTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        )),
      ),
    );
  }
}
