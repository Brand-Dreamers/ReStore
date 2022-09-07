import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/screens/home.dart';
import 'dart:convert';

import 'package:restore/services/authservice.dart';

class Stamp extends StatefulWidget {
  const Stamp({Key? key}) : super(key: key);

  @override
  State<Stamp> createState() => _StampState();
}

class _StampState extends State<Stamp> {
  late Future<PDFData> futureData;
  late PDFData pdfData;
  late PdfControllerPinch _controller;

  @override
  void initState() {
    super.initState();
    futureData = loadPDF();
    futureData.then((value) {
      pdfData = value;
      _controller =
          PdfControllerPinch(document: PdfDocument.openData(value.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    void changeScreen() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
    Size size = MediaQuery.of(context).size;


    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Stamp Document",
            style: emphasizedSubheader.copyWith(
                fontSize: 20, fontWeight: FontWeight.w400),
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FutureBuilder(
                    future: futureData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Popup();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {
                          PDFData data = snapshot.data as PDFData;
                          if (data.data.isEmpty) {
                            return const Center(
                              child: Text("No File Was Selected"),
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5.0),
                                  child: SizedBox(
                                      width: size.width,
                                      height: size.height - 180,
                                      child: PdfViewPinch(
                                          controller: _controller)),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6.0),
                                            topRight: Radius.circular(6.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: const Text("Cancel"),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    const Popup(
                                                      message: "Uploading File",
                                                    ));
                                            String encode =
                                                base64.encode(pdfData.data);
                                            await AuthService.getService()
                                                .postDocument(DocumentInfo(
                                                    data: encode,
                                                    title: pdfData.filename));
                                            changeScreen();
                                          },
                                          child: Text("Upload",
                                              style:
                                                  emphasizedSubheader.copyWith(
                                                      color: buttonColor)),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        } else {
                          return const Center(
                              child: Text(
                                  "Something Went Wrong. Please Try Again!"));
                        }
                      } else {
                        return const Center(
                            child: Text(
                                "An Error Occured On The Server. Contact The Developer!"));
                      }
                    }))));
  }
}
