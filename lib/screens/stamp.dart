import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';
import 'package:restore/components/constants.dart';

class Stamp extends StatefulWidget {
  const Stamp({Key? key}) : super(key: key);

  @override
  State<Stamp> createState() => _StampState();
}

class _StampState extends State<Stamp> {
  late Future<PDFData> futureData;
  late PDFData pdfData;
  late PdfController _controller;

  @override
  void initState() {
    super.initState();
    futureData = loadPDF();
    futureData.then((value) {
      pdfData = value;
      _controller =
          PdfController(document: PdfDocument.openData(value.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showStampPanel(PDFData pdfData) {
      showModalBottomSheet(
          context: context, builder: (context) => StampPanel(data: pdfData));
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Stamp Document",
          style: subtitleTextStyle,
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Stack(children: [
          FutureBuilder(
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
                      return DragTarget(
                        builder: (context, candidateData, rejectedData) {
                          return PdfView(controller: _controller);
                        },
                        onWillAccept: (data) => data == "Stamp Image",
                        onAccept: (data) {},
                      );
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
          Draggable(
            child: Image.asset("assets/images/dummy stamp.png", height: 150, width: 150),
            feedback: Image.asset("assets/images/dummy stamp.png", height: 150, width: 150),
            childWhenDragging: Image.asset("assets/images/dummy stamp.png", height: 150, width: 150),

          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStampPanel(pdfData),
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
  String? dataName;
  double? xOffset;
  double? yOffset;

  DragData({this.dataName, this.xOffset, this.yOffset});
}

class StampPanel extends StatefulWidget {
  final PDFData data;
  const StampPanel({Key? key, required this.data}) : super(key: key);

  @override
  State<StampPanel> createState() => _StampPanelState();
}

class _StampPanelState extends State<StampPanel> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _controller.text = widget.data.filename;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 250.0,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Stamp A Document", style: littleHeaderTextStyle),
            const SizedBox(
              height: 50,
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
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  widget.data.filename = _controller.text;
                  //createAndSavePDF(widget.data);
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
    );
  }
}
