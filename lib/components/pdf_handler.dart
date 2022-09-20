import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'package:restore/components/constants.dart';

class PDFData {
  String filename;
  Uint8List data;

  PDFData({required this.filename, required this.data});
}

Future<PDFData> loadPDF() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
  if (result != null) {
    var res = result.files.single;
    Uint8List data = File(res.path as String).readAsBytesSync();
    return PDFData(filename: res.name, data: data);
  }
  return PDFData(filename: "Null file", data: Uint8List(0));
}

Future<String> createAndSavePDF(PDFData pdfData, Uint8List stampData,
    double xOffset, double yOffset) async {
  if (pdfData.data.isEmpty) return "";
  final pdf = pw.Document();
  final pdfImage = pw.MemoryImage(pdfData.data);
  final stampImage = pw.MemoryImage(stampData);
  pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(
        child: pw.Stack(children: [
      pw.Image(pdfImage),
      pw.Positioned(
          left: xOffset,
          top: yOffset,
          child: pw.Image(stampImage,
              width: stampImageSize, height: stampImageSize))
    ]));
  }));

  return base64.encode(await pdf.save());
}
