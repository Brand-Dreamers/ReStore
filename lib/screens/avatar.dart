import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/home.dart';

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
                color: headerColor,
              ),
            )),
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Choose Avatar", style: headerTextStyle),
                const SizedBox(
                  height: 10,
                ),
                Text("Trust me, this is the last step...",
                    style: subtitleTextStyle),
                const SizedBox(
                  height: 40,
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
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Image.network(
                                      api + _avatarURLS[i] + ext)),
                              _selectedAvatar == _avatarURLS[i]
                                  ? const Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: buttonColor,
                                        child: Icon(Icons.done_outline,
                                            color: backgroundColor),
                                      ),
                                    )
                                  : const Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.transparent,
                                        child: Icon(Icons.done_outline,
                                            color: Colors.transparent),
                                      ),
                                    )
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
                                builder: (context) => const Home()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please select an avatar")));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(5),
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
