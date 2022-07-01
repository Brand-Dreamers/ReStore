import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/settings.dart';
import 'package:restore/screens/account.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  late PdfControllerPinch pinchController;
  late PDFData pdfData;
  late Future<PDFData> futureData;

  @override
  void initState() {
    super.initState();
    futureData = loadPDF();
    futureData.then((value) {
      pdfData = value;
      pinchController =
          PdfControllerPinch(document: PdfDocument.openData(value.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
            child: const Icon(
              Icons.menu,
              color: subtitleColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Upload Document",
              style: subtitleTextStyle,
            ),
            GestureDetector(
              onTap: () {
                setState(() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Account())));
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(api + User.getUser().avatarURL + ext),
                radius: 15.0,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(child: PdfViewPinch(controller: pinchController))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.upload_file_outlined,
          color: backgroundColor,
        ),
        tooltip: "Upload",
      ),
    );
  }
}
