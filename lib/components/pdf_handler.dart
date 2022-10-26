import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

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
