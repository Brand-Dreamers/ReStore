import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/services/authservice.dart';

class Slide extends StatelessWidget {
  final String slideImageURL;
  final String topHeaderText;
  final String bottomHeaderText;
  final String description;

  const Slide(
      {Key? key,
      required this.slideImageURL,
      required this.topHeaderText,
      required this.bottomHeaderText,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topHeaderText,
            style: emphasizedHeader,
          ),
          Text(
            bottomHeaderText,
            style: emphasizedHeader,
          ),
          const SizedBox(height: 5),
          Text(description, style: emphasizedSubheader),
          const SizedBox(
            height: 50,
          ),
          Center(child: Image.asset(slideImageURL)),
        ],
      ),
    );
  }
}

List<Slide> startSlides = [
  const Slide(
    topHeaderText: "Easy",
    bottomHeaderText: "Document Stamping",
    description: "With Restore, you can stamp your documents online with ease",
    slideImageURL: "images/start 1.png",
  ),
  const Slide(
    topHeaderText: "Save",
    bottomHeaderText: "Your Time",
    description:
        "Manage your time by saving yourself the stress of manual stamping",
    slideImageURL: "images/start 2.png",
  ),
  const Slide(
    topHeaderText: "Upload",
    bottomHeaderText: "Your Documents",
    description: "Save and upload your documents for later use",
    slideImageURL: "images/start 3.png",
  ),
];

class SlideContainer extends StatefulWidget {
  const SlideContainer({Key? key}) : super(key: key);

  @override
  State<SlideContainer> createState() => _SlideContainerState();
}

class _SlideContainerState extends State<SlideContainer> {
  final List<Slide> slides = startSlides;
  late PageController pageController;
  late int currentSlide;
  bool isLast = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    currentSlide = 0;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int length = startSlides.length;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size.height * 0.75,
                    child: PageView.builder(
                        controller: pageController,
                        pageSnapping: true,
                        itemCount: length,
                        onPageChanged: (index) {
                          setState(() {
                            currentSlide = index;
                            isLast = (index == length - 1);
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => slides[index]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(length, (index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: (index == currentSlide)
                                        ? buttonColor
                                        : const Color.fromARGB(
                                            255, 230, 230, 227)),
                              ),
                              const SizedBox(width: 2.5),
                            ]);
                      }),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                currentSlide = length - 1;
                                pageController.animateToPage(currentSlide,
                                    duration: const Duration(milliseconds: 750),
                                    curve: Curves.easeOut);
                              });
                            },
                            child: Text("Skip",
                                style: emphasizedSubheader.copyWith(
                                    fontSize: 18))),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!isLast) {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AuthService.getService()));
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: isLast ? 100 : 50,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: isLast
                                    ? Text("Get Started",
                                        style: emphasizedHeader.copyWith(
                                            color: backgroundColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal))
                                    : const Icon(
                                        Icons.arrow_right_alt,
                                        color: backgroundColor,
                                      ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
