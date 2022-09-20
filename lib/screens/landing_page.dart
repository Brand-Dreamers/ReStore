import 'package:flutter/material.dart';
import 'package:restore/screens/settings.dart';
import 'package:restore/screens/home.dart';
import 'package:restore/components/constants.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late double xOffset;
  late double yOffset;
  late double scale;
  late bool isMenuOpen;

  void openMenu() => setState(() {
        xOffset = 250;
        yOffset = 150;
        scale = 0.6;
        isMenuOpen = true;
      });

  void closeMenu() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scale = 1;
        isMenuOpen = false;
      });

  @override
  void initState() {
    super.initState();
    closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Stack(
          children: [
            Settings(
              closeMenu: closeMenu,
            ),
            GestureDetector(
              onTap: closeMenu,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.translationValues(xOffset, yOffset, 0)
                    ..scale(scale),
                  child: AbsorbPointer(
                    absorbing: isMenuOpen,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isMenuOpen ? 15 : 0),
                      child: Container(
                        color: backgroundColor,
                        child: Home(
                          openMenu: openMenu,
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
