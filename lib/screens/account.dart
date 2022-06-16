import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: CircularProfileAvatar(
                      api + User.getUser().avatarURL + ext,
                      radius: 75,
                      backgroundColor: backgroundColor,
                      cacheImage: true,
                      elevation: 8.0,
                      imageFit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Text(User.getUser().surname + " " + User.getUser().lastname, style: subtitleTextStyle),
                  const SizedBox(height: 10),
                  Text(User.getUser().email, style: subtitleTextStyle),
                  const SizedBox(height: 10),
                  Text(User.getUser().matricNumber, style: subtitleTextStyle),
                  const SizedBox(height: 10),
                  Text(User.getUser().department, style: subtitleTextStyle),
                  const SizedBox(height: 10),
                  Text(User.getUser().college, style: subtitleTextStyle),
              ]),
      )));
  }
}
