import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';
import 'package:restore/components/constants.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';

class Stamp extends StatefulWidget {
  const Stamp({Key? key}) : super(key: key);

  @override
  State<Stamp> createState() => _StampState();
}

class _StampState extends State<Stamp> {
  late Future<PDFData> futureData;
  late PDFData pdfData;
  late PdfController _controller;
  final DragData dragData = DragData();

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
    void stamp() => showDialog(
        context: context,
        builder: (context) {
          return StampPanel(
            data: pdfData,
            onStamp: () async {
              String stampPath = "assets/images/dummy stamp.png";
              ByteData bytes = await rootBundle.load(stampPath);
              Uint8List stampData = bytes.buffer
                  .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
              createAndSavePDF(
                  pdfData, stampData, dragData.xOffset, dragData.yOffset);
            },
          );
        });

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
        child: FutureBuilder(
            future: futureData,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Wait();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  PDFData pdf = snapshot.data as PDFData;
                  if (pdf.data.isEmpty) {
                    return const NotificationContainer(
                        message: "No file was selected!",
                        imageURL: "assets/images/error.png");
                  } else {
                    return Stack(children: [
                      PdfView(controller: _controller),
                      Positioned(
                        left: dragData.xOffset,
                        top: dragData.yOffset,
                        child: Draggable<DragData>(
                          child: Image.asset("assets/images/dummy stamp.png",
                              height: stampImageSize, width: stampImageSize),
                          feedback: Image.asset("assets/images/dummy stamp.png",
                              height: stampImageSize, width: stampImageSize),
                          childWhenDragging: const SizedBox(
                              height: stampImageSize, width: stampImageSize),
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
                        ),
                      ),
                    ]);
                  }
                } else {
                  return const NotificationContainer(
                      message: "Something went wrong... Please try again!",
                      imageURL: "assets/images/fatal error.png");
                }
              } else {
                return const NotificationContainer(
                    message: "An error occurred while loading the PDF",
                    imageURL: "assets/images/fatal error.png");
              }
            })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => stamp(),
        child: const Icon(
          Icons.save,
          color: backgroundColor,
        ),
        tooltip: "Stamp",
      ),
    );
  }
}

class DragData {
  double xOffset;
  double yOffset;

  DragData({this.xOffset = 0.0, this.yOffset = 0.0});
}

class StampPanel extends StatefulWidget {
  final VoidCallback onStamp;
  final PDFData data;
  const StampPanel({Key? key, required this.data, required this.onStamp})
      : super(key: key);

  @override
  State<StampPanel> createState() => _StampPanelState();
}

class _StampPanelState extends State<StampPanel> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.data.filename;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        height: 220.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Stamp Document",
                  style: emphasizedHeader.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: size.width - 40,
                      decoration: BoxDecoration(
                        color: fieldColor,
                        border: Border.all(
                          color: borderColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(Icons.file_open,
                                    size: 18, color: iconColor)),
                            border: InputBorder.none,
                            hintText: "Filename",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    widget.data.filename = _controller.text;
                    widget.onStamp();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Text("Stamp", style: buttonTextStyle)),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
