import 'dart:typed_data';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';

class PDFData {
  final String filename;
  final Uint8List data;

  const PDFData({required this.filename, required this.data});
}

Future<PDFData> _loadPDF() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowedExtensions: [
    'pdf',
  ], type: FileType.custom);
  if (result != null) {
    var res = result.files.single;
    Uint8List data = File(res.path as String).readAsBytesSync();
    return PDFData(filename: res.name, data: data);
  }
  return PDFData(filename: "Null file", data: Uint8List(0));
}

Future<void> _createAndSavePDF(PDFData pdfData) async{
  final pdf = pw.Document();
  final pdfImage = pw.MemoryImage(pdfData.data);
  pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(
        child: pdfData.data.isEmpty ? pw.Text("Empty File") : pw.Image(pdfImage));
  }));

  final file = File(pdfData.filename + '-stamped.pdf');
  await file.writeAsBytes(await pdf.save());
}

class PdfHandler extends StatefulWidget {
  const PdfHandler({Key? key}) : super(key: key);

  @override
  State<PdfHandler> createState() => _PdfHandlerState();
}

class _PdfHandlerState extends State<PdfHandler> {
  late PDFData pdfData;
  late PdfControllerPinch pinchController;

  @override
  void initState() {
    super.initState();
    _loadPDF().then((value) {
      pdfData = value;
      pinchController =
          PdfControllerPinch(document: PdfDocument.openData(value.data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: _loadPDF(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: buttonColor,
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    PDFData pdf = snapshot.data as PDFData;
                    if (pdf.data.isEmpty) {
                      return Text(
                        "Empty PDF",
                        style: littleHeaderTextStyle,
                      );
                    } else {
                      return PdfViewPinch(controller: pinchController);
                    }
                  } else {
                    return Text(
                      "Snapshot Error",
                      style: littleHeaderTextStyle,
                    );
                  }
                } else {
                  return Text(
                    "Error with loading the PDF",
                    style: littleHeaderTextStyle,
                  );
                }
              })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createAndSavePDF(pdfData),
        child: const Icon(Icons.save, color: backgroundColor,),
      ),
    );
  }
}
