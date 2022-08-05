import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';

class Settings extends StatelessWidget {
  final List<DrawerItem> profileItems = [
    DrawerItem(
      name: User.getUser().surname + " " + User.getUser().lastname,
      iconData: Icons.person_outline_rounded,
    ),
    DrawerItem(
        name: User.getUser().matricNumber, iconData: Icons.bookmarks_outlined),
    DrawerItem(
      name: User.getUser().college,
      iconData: Icons.house_outlined,
    ),
    DrawerItem(
      name: User.getUser().department,
      iconData: Icons.business_outlined,
    ),
    DrawerItem(
      name: User.getUser().level,
      iconData: Icons.grade_outlined,
    ),
    DrawerItem(
      name: User.getUser().email,
      iconData: Icons.mail_outline_rounded,
    )
  ];

  final List<DrawerItem> actionItems = [
    const DrawerItem(
      name: "My Documents",
      iconData: Icons.document_scanner_rounded,
    ),
    const DrawerItem(
        name: "Notification", iconData: Icons.notifications_rounded),
    const DrawerItem(
        name: "Change Password", iconData: Icons.lock_outline_rounded),
    const DrawerItem(name: "Log Out", iconData: Icons.logout_rounded)
  ];

  final VoidCallback closeMenu;
  Settings({Key? key, required this.closeMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _executeOnTap(int index) {}
    return WillPopScope(
      onWillPop: () async {
        closeMenu();
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: closeMenu,
                icon: const Icon(Icons.chevron_left_rounded,
                    color: Colors.white)),
            const SizedBox(height: 5),
            CircleAvatar(
              backgroundImage:
                  NetworkImage(api + User.getUser().avatarURL + ext),
              radius: 15.0,
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 5),
            Column(
                children: profileItems
                    .map((item) => ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          leading: Icon(item.iconData, color: Colors.white),
                          title: Text(item.name,
                              style: emphasizedSubheader.copyWith(
                                  color: Colors.white)),
                        ))
                    .toList()),
            const SizedBox(height: 10),
            Column(
              children: List.generate(
                  actionItems.length,
                  (index) => GestureDetector(
                      onTap: () => _executeOnTap(index),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        leading: Icon(actionItems[index].iconData, color: Colors.white),
                        title: Text(actionItems[index].name,
                            style: emphasizedSubheader.copyWith(
                                color: Colors.white)),
                        onTap: () => _executeOnTap(index),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final String name;
  final IconData iconData;
  const DrawerItem({required this.name, required this.iconData});
}
