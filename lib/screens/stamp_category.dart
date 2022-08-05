import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/screens/stamp.dart';

class StampCategory extends StatelessWidget {
  const StampCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Select the stamp category",
          style: subtitleTextStyle,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Stamp())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 80,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 218, 218),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Student Union",
                            style: emphasizedHeader.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        const Icon(Icons.chevron_right_rounded,
                            color: Colors.black45),
                      ],
                    ),
                  ),
                ),
              )
            ])
          ],
        ),
      )),
    );
  }
}
