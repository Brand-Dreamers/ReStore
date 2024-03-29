import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/stamp.dart';
import 'package:restore/screens/upload.dart';
import 'package:restore/screens/view.dart';

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
      width: 140,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1, color: buttonColor)),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageURL,
            width: 130,
            height: 100,
          ),
          Text(header,
              style: emphasizedHeader.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(description,
                style: emphasizedSubheader.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w400)),
          ),
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
  late VoidCallback logout;

  List<HomeSlide> homeSlides = [
    const HomeSlide(
      imageURL: "images/document.png",
      header: "Stamp",
      description: "Get your documents stamped",
    ),
    const HomeSlide(
      imageURL: "images/upload.png",
      header: "Upload",
      description: "Save and upload your documents",
    ),
    const HomeSlide(
      imageURL: "images/stamp.png",
      header: "Documents",
      description: "View uploaded and stamped documents",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _executeOnTap(int index) {
      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Stamp()));
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Upload()));
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ViewDocuments()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black45,
            ),
            onPressed: widget.openMenu),
        title: Text(
          "Restore",
          style: emphasizedHeader.copyWith(
              fontSize: 24, fontWeight: FontWeight.w500, color: buttonColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome, ${User.getUser()!.email}",
                          style: emphasizedHeader.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: buttonColor),
                        ),
                        Text(
                          "What would you like to do today?",
                          style: emphasizedSubheader.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: () => _executeOnTap(0),
                                      child: homeSlides[0]),
                                  const SizedBox(width: 10),
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
        ),
      ),
    );
  }
}
