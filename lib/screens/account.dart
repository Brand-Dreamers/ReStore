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
                  const SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(api + User.getUser().avatarURL + ext),
                      radius: 100,
                      backgroundColor: Colors.transparent,
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
