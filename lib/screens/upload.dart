import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/screens/landing_page.dart';
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
    void changeScreen() => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LandingPage()));

    void upload() async {
      showDialog(
          context: context,
          builder: (context) => const Popup(
                message: "Uploading Document",
              ));

      String encode = base64.encode(pdfData.data);
      Future<String> res = AuthService.getService()
          .postDocument(DocumentInfo(data: encode, title: pdfData.filename));
      res.then((value) {
        if (value == success) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Document Successfully Uploaded"),
            elevation: 1.0,
            dismissDirection: DismissDirection.down,
            duration: Duration(seconds: 3),
          ));
          changeScreen();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value),
            elevation: 1.0,
            dismissDirection: DismissDirection.down,
            duration: const Duration(seconds: 3),
          ));
          setState(() {});
        }
      });
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left_rounded, color: buttonColor)),
          title: Text(
            "Upload Document",
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
                                  height: size.height - 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child:
                                        PdfViewPinch(controller: _controller),
                                  )),
                            ),
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
                })),
        floatingActionButton: FloatingActionButton(
          onPressed: () => upload(),
          child: const Icon(Icons.upload_file_rounded),
        ));
  }
}
