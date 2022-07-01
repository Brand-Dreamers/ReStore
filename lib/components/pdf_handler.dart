import 'dart:typed_data';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';

class PDFData {
  String filename;
  Uint8List data;

  PDFData({required this.filename, required this.data});
}

Future<PDFData> loadPDF() async {
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

Future<bool> createAndSavePDF(PDFData pdfData) async {
  if (pdfData.data.isEmpty) return false;
  final pdf = pw.Document();
  final pdfImage = pw.MemoryImage(pdfData.data);
  pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(
        child:
            pdfData.data.isEmpty ? pw.Text("Empty File") : pw.Image(pdfImage));
  }));

  final file = File(pdfData.filename + '-stamped.pdf');
  await file.writeAsBytes(await pdf.save());
  return true;
}

Future<bool> uploadPDF(PDFData pdfData) async {
  if (pdfData.data.isEmpty) return false;
  return true;
}
