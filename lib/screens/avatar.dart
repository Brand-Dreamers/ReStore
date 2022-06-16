import 'package:circular_profile_avatar/circular_profile_avatar.dart';
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
  String? _selectedAvatar;
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
                  height: 50,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    shrinkWrap: true,
                    children: List.generate(4, (i) {
                      return CircularProfileAvatar(
                        api + _avatarURLS[i] + ext,
                        backgroundColor: backgroundColor,
                        cacheImage: true,
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        placeHolder: (context, url) => const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                        elevation: 8.0,
                        imageFit: BoxFit.fitHeight,
                        foregroundColor: _selectedAvatar == _avatarURLS[i]
                            ? Colors.black38
                            : Colors.transparent,
                        onTap: () {
                          setState(() {
                            _selectedAvatar = _avatarURLS[i];
                          });
                        },
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      User.getUser().avatarURL = _selectedAvatar as String;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
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
