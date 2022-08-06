import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/landing_page.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

Future<bool> willPop() async {
  return false;
}

class _AvatarState extends State<Avatar> {
  String _selectedAvatar = "";
  final List<String> _avatarURLS = getAvatarURLS(4);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.chevron_left_outlined,
                size: 30,
                color: Colors.black,
              ),
            )),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text("Choose Avatar",
                    style: emphasizedHeader.copyWith(
                        fontSize: 28, fontWeight: FontWeight.w800)),
                const SizedBox(
                  height: 5,
                ),
                Text("Trust me, this is the last step...",
                    style: emphasizedSubheader.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      shrinkWrap: true,
                      children: List.generate(
                        4,
                        (i) {
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedAvatar =
                                  (_selectedAvatar == _avatarURLS[i])
                                      ? ""
                                      : _selectedAvatar = _avatarURLS[i]);
                            },
                            child: Stack(children: [
                              SizedBox(
                                  child:
                                      Image.asset("assets/images/welcome.png")),
                              Container(
                                decoration: BoxDecoration(
                                    color: _selectedAvatar == _avatarURLS[i]
                                        ? const Color.fromARGB(20, 0, 0, 0)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(Icons.done_rounded,
                                      color: _selectedAvatar == _avatarURLS[i]
                                          ? buttonColor
                                          : Colors.transparent))
                            ]),
                          );
                        },
                      ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_selectedAvatar != "") {
                        User.getUser().avatarURL = _selectedAvatar;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LandingPage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Center(
                                    child: Text("Please select an avatar"))));
                      }
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: Text("Complete", style: buttonTextStyle)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
