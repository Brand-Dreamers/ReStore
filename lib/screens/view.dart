import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/services/authservice.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'dart:io';

class View extends StatefulWidget {
  final DocumentInfo data;
  const View({Key? key, required this.data}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  late PdfControllerPinch _controller;
  late Uint8List data;
  bool showPopup = false;

  @override
  void initState() {
    super.initState();
    data = base64.decode(widget.data.data);
    _controller = PdfControllerPinch(document: PdfDocument.openData(data));
  }

  @override
  Widget build(BuildContext context) {
    void changeScreen() => Navigator.pop(context);

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: buttonColor,
            title: Text(widget.data.title),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () async {
                  if (showPopup) {
                    showDialog(
                        context: context,
                        builder: (context) => const Popup(
                              message: "Saving Document",
                            ));
                  }

                  final permissionValidator = EasyPermissionValidator(
                    context: context,
                    appName: 'Restore',
                  );
                  var result = await permissionValidator.storage();
                  if (result) {
                    Directory? dir = await getExternalStorageDirectory();
                    String filePath = "${dir?.path}/${widget.data.title}";
                    File file = File(filePath);
                    file.writeAsBytes(data);
                    changeScreen();
                  }
                  else
                  {
                    setState(() => showPopup = false);
                  }
                  
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.download),
                ),
              ),
            ]),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PdfViewPinch(controller: _controller),
        )));
  }
}

class ViewDocuments extends StatefulWidget {
  const ViewDocuments({Key? key}) : super(key: key);

  @override
  State<ViewDocuments> createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  late Future<List<DocumentInfo>?> documents;

  @override
  void initState() {
    super.initState();
    documents = AuthService.getService().getUserDocuments();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        title: Text(
          "Restore",
          style: emphasizedSubheader.copyWith(
              color: buttonColor, fontWeight: FontWeight.w400, fontSize: 24),
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height - 180,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                          child: FutureBuilder(
                              future: documents,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Popup();
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    List<DocumentInfo>? userDocuments =
                                        snapshot.data as List<DocumentInfo>?;
                                    if (userDocuments == null ||
                                        userDocuments.isEmpty) {
                                      return Text("No Documents Uploaded",
                                          style: emphasizedSubheader.copyWith(
                                              fontSize: 16));
                                    } else {
                                      return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: userDocuments.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                                title: Text(
                                                    userDocuments[index].title),
                                                subtitle: Text(
                                                    userDocuments[index].size),
                                                leading: Image.asset(
                                                  "images/pdf.png",
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                trailing: GestureDetector(
                                                    onTap: () async {
                                                      await AuthService
                                                              .getService()
                                                          .deleteDocument(
                                                              userDocuments[
                                                                      index]
                                                                  .id);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                        Icons.delete_rounded)),
                                                onTap: () =>
                                                    Navigator.pushReplacement(
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
                                        child: Text(
                                            "Something Went Wrong. Please Try Again!"));
                                  }
                                } else {
                                  return const Center(
                                      child: Text(
                                          "An Error Occured On The Server. Contact The Developer!"));
                                }
                              })),
                    ),
                  ),
                ]),
          ),
        ],
      )),
    );
  }
}
