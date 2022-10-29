import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/services/authservice.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'dart:io';

class View extends StatefulWidget {
  final PDFData data;
  const View({Key? key, required this.data}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  late Uint8List data;
  late PdfControllerPinch _controller;

  int page = 1;
  bool showPopup = false;

  @override
  void initState() {
    super.initState();
    data = base64.decode(widget.data.encodedData);
    _controller = PdfControllerPinch(
        document: PdfDocument.openData(data), initialPage: page);
  }

  @override
  Widget build(BuildContext context) {
    void _save() {
      showDialog(context: context, builder: (context) => const Popup());

      final permissionValidator = EasyPermissionValidator(
        context: context,
        appName: 'Restore',
      );
      Future<bool> res = permissionValidator.storage();
      res.then((value) {
        if (value) {
          Future<Directory?> dir = getExternalStorageDirectory();
          dir.then((value) {
            String filePath = "${value!.path}/${widget.data.filename}";
            File file = File(filePath);
            file.writeAsBytes(data);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${widget.data.filename} Saved"),
              elevation: 1.0,
              dismissDirection: DismissDirection.down,
              duration: const Duration(seconds: 3),
            ));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("An Error Occured Saving ${widget.data.filename}"),
            elevation: 1.0,
            dismissDirection: DismissDirection.down,
            duration: const Duration(seconds: 3),
          ));
        }
        Navigator.pop(context);
      });

      setState(() {});
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: buttonColor,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chevron_left_rounded,
                    color: Colors.white)),
            title: Text(widget.data.filename),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () => _save(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.download),
                ),
              ),
            ]),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PdfViewPinch(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (p) => page = p,
                ))));
  }
}

class ViewDocuments extends StatefulWidget {
  const ViewDocuments({Key? key}) : super(key: key);

  @override
  State<ViewDocuments> createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  late Future<List<PDFData>?> documents;

  @override
  void initState() {
    super.initState();
    documents = AuthService.getService().getUserDocuments();
  }

  @override
  Widget build(BuildContext context) {
    void onDelete(String id, String filename) {
      showDialog(
          useSafeArea: true,
          barrierDismissible: false,
          context: context,
          builder: (context) => const Popup());

      Future<String> res = AuthService.getService().deleteDocument(id);
      res.then((value) {
        if (value == success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Deleted $filename Succesfully"),
            elevation: 1.0,
            dismissDirection: DismissDirection.down,
            duration: const Duration(seconds: 3),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value),
            elevation: 1.0,
            dismissDirection: DismissDirection.down,
            duration: const Duration(seconds: 3),
          ));
        }
        setState(() {});
        Navigator.pop(context);
      });
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left_rounded, color: buttonColor)),
          title: Text(
            "View Documents",
            style: emphasizedSubheader.copyWith(
                color: buttonColor, fontWeight: FontWeight.w400, fontSize: 20),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
            height: size.height - 100,
            child: Center(
              child: FutureBuilder(
                future: documents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Popup();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<PDFData>? userDocuments =
                          snapshot.data as List<PDFData>?;
                      if (userDocuments == null || userDocuments.isEmpty) {
                        return Text("No Documents Uploaded",
                            style: emphasizedSubheader.copyWith(fontSize: 16));
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: userDocuments.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text(
                                    userDocuments[index].filename,
                                  ),
                                  leading: Image.asset(
                                    "images/pdf.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () => onDelete(
                                          userDocuments[index].documentId,
                                          userDocuments[index].filename),
                                      child: const Icon(Icons.delete_rounded)),
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => View(
                                                data: userDocuments[
                                                    index])), // Show the document
                                      ));
                            });
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
                },
              ),
            ),
          )),
        ));
  }
}
