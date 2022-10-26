import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';
import 'package:restore/components/constants.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:restore/services/authservice.dart';

class Stamp extends StatefulWidget {
  const Stamp({Key? key}) : super(key: key);

  @override
  State<Stamp> createState() => _StampState();
}

class DragData {
  double xOffset;
  double yOffset;

  DragData({this.xOffset = 0.0, this.yOffset = 0.0});
}

class _StampState extends State<Stamp> {
  late Future<PDFData> futureData;
  late PDFData pdfData;
  late PdfController _controller;
  final DragData dragData = DragData();
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    futureData = loadPDF();
    futureData.then((value) {
      pdfData = value;
      _controller = PdfController(document: PdfDocument.openData(value.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    void message(String message) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          elevation: 1.0,
          dismissDirection: DismissDirection.down,
          duration: const Duration(seconds: 3),
        ));

    void changeScreen() => Navigator.pop(context);

    Size size = MediaQuery.of(context).size;

    void _stamp() async {
      if (_showPopup) {
        showDialog(
            useSafeArea: true,
            barrierDismissible: false,
            context: context,
            builder: (context) => const Popup(message: "Stamping Document"));
      }

      // String stampPath = "images/dummy stamp.png";
      // ByteData bytes = await rootBundle.load(stampPath);
      // Uint8List stampData =
      //     bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      // String data = await createAndSavePDF(
      //     pdfData, stampData, dragData.xOffset, dragData.yOffset);

      // if (data != "") {
      //   Future<String> res = AuthService.getService()
      //       .postDocument(DocumentInfo(data: data, title: pdfData.filename));
      //   res.then((value) {
      //     if (value == success) {
      //       message("Document Stamp Success");
      //       changeScreen();
      //     } else {
      //       setState(() => _showPopup = false);
      //       message(value);
      //     }
      //   });
      // } else {
      //   setState(() => _showPopup = false);
      //   message("Document Stamp Failed");
      // }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.chevron_left_rounded, color: buttonColor)),
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
                        return Stack(children: [
                          PdfView(controller: _controller),
                          Positioned(
                            left: dragData.xOffset,
                            top: dragData.yOffset,
                            child: Draggable<DragData>(
                              feedback: Image.asset("images/dummy stamp.png",
                                  height: stampImageSize,
                                  width: stampImageSize),
                              childWhenDragging: const SizedBox(
                                  height: stampImageSize,
                                  width: stampImageSize),
                              data: dragData,
                              onDragUpdate: (details) {
                                setState(() {
                                  dragData.xOffset += details.delta.dx;
                                  dragData.yOffset += details.delta.dy;

                                  dragData.xOffset = dragData.xOffset < 0.0
                                      ? 0.0
                                      : dragData.xOffset;

                                  dragData.yOffset = dragData.yOffset < 0.0
                                      ? 0.0
                                      : dragData.yOffset;

                                  double limit = size.width - stampImageSize;
                                  dragData.xOffset = (dragData.xOffset > limit)
                                      ? limit
                                      : dragData.xOffset;

                                  limit = size.height - stampImageSize;
                                  dragData.yOffset = (dragData.yOffset > limit)
                                      ? limit
                                      : dragData.yOffset;
                                });
                              },
                              child: Image.asset("images/dummy stamp.png",
                                  height: stampImageSize,
                                  width: stampImageSize),
                            ),
                          ),
                        ]);
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
          onPressed: () {
            setState(() => _showPopup = true);
            _stamp();
          },
          child: const Icon(Icons.upload_file_rounded),
        ));
  }
}
