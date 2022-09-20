import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';
import 'package:restore/components/constants.dart';
import 'dart:convert';

import 'package:restore/services/authservice.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
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
    void changeScreen() => Navigator.pop(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const SizedBox(),
          title: Text(
            "Stamp Document",
            style: emphasizedSubheader.copyWith(
                fontSize: 20, fontWeight: FontWeight.w400, color: buttonColor),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Popup();
                  } else if (snapshot.connectionState == ConnectionState.done) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                  width: size.width,
                                  height: size.height - 170,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child:
                                        PdfViewPinch(controller: _controller),
                                  )),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text(
                                              "Cancel",
                                              style:
                                                  emphasizedSubheader.copyWith(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ))),
                                    GestureDetector(
                                      onTap: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) => const Popup(
                                                  message: "Uploading Document",
                                                ));
                                        String encode =
                                            base64.encode(pdfData.data);
                                        await AuthService.getService()
                                            .postDocument(DocumentInfo(
                                                data: encode,
                                                title: pdfData.filename));
                                        changeScreen();
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text("Upload",
                                              style:
                                                  emphasizedSubheader.copyWith(
                                                      color: buttonColor,
                                                      fontSize: 18))),
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
                          child:
                              Text("Something Went Wrong. Please Try Again!"));
                    }
                  } else {
                    return const Center(
                        child: Text(
                            "An Error Occured On The Server. Contact The Developer!"));
                  }
                })));
  }
}
