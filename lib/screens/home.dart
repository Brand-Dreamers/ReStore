import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/stamp_category.dart';
import 'package:restore/screens/upload.dart';
import 'package:restore/screens/view_documents.dart';

class HomeSlide extends StatelessWidget {
  final String imageURL;
  final String header;
  final String description;

  const HomeSlide({
    Key? key,
    required this.imageURL,
    required this.header,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1.0, color: buttonColor)),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageURL,
            width: 150,
            height: 150,
          ),
          Text(header, style: emphasizedHeader.copyWith(fontSize: 20)),
          Text(description, style: emphasizedSubheader.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  final VoidCallback openMenu;
  const Home({Key? key, required this.openMenu}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeSlide> homeSlides = [
    const HomeSlide(
      imageURL: "assets/images/stamp.png",
      header: "Stamp",
      description: "Get your documents stamped",
    ),
    const HomeSlide(
      imageURL: "assets/images/upload.png",
      header: "Upload",
      description: "Save and upload your documents",
    ),
    const HomeSlide(
      imageURL: "assets/images/document.png",
      header: "Documents",
      description: "View your uploaded and stamped documents",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _navigateStamp() => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const StampCategory()));

    void _navigateUpload() => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Upload()));

    void _navigateDocuments() => Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ViewDocuments()));

    void _executeOnTap(int index) {
      if (index == 0) {
        _navigateStamp();
      } else if (index == 1) {
        _navigateUpload();
      } else if (index == 2) {
        _navigateDocuments();
      }
    }

    return SizedBox(
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: subtitleColor,
                  ),
                  onPressed: widget.openMenu),
              Text(
                "Restore",
                style: headerEmphasisTextStyle,
              ),
              CircleAvatar(
                backgroundImage:
                    NetworkImage(api + User.getUser().avatarURL + ext),
                radius: 15.0,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          SingleChildScrollView(
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
                      "Welcome, " + User.getUser().lastname,
                      style: emphasizedHeader,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "What would you like to do today?",
                      style: emphasizedSubheader,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () => _executeOnTap(0),
                                  child: homeSlides[0]),
                              GestureDetector(
                                  onTap: () => _executeOnTap(1),
                                  child: homeSlides[1]),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () => _executeOnTap(2),
                                  child: homeSlides[2]),
                            ],
                          ),
                        ]),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
