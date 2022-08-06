import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/pdf_handler.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  late Future<PDFData> futureData;
  late PDFData pdfData;
  late PdfControllerPinch pinchController;

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
    void _showUploadPanel(PDFData pdfData) {
      showModalBottomSheet(
          context: context, builder: (context) => UploadPanel(data: pdfData));
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Upload Document",
          style: emphasizedSubheader.copyWith(fontSize: 16),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(child: PdfViewPinch(controller: pinchController))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUploadPanel(pdfData),
        child: const Icon(
          Icons.upload_file_outlined,
          color: backgroundColor,
        ),
        tooltip: "Upload",
      ),
    );
  }
}

class UploadPanel extends StatefulWidget {
  final PDFData data;
  const UploadPanel({Key? key, required this.data}) : super(key: key);

  @override
  State<UploadPanel> createState() => _UploadPanelState();
}

class _UploadPanelState extends State<UploadPanel> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
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
            Text("Upload Document", style: emphasizedHeader.copyWith(fontSize: 16)),
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
