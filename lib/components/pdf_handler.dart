import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

Future<Uint8List?> loadPDF() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
  if (result != null) {
    return File(result.files.single.path as String).readAsBytesSync();
  }
  return null;
}

class PdfEditScreen extends StatefulWidget {
  const PdfEditScreen({Key? key}) : super(key: key);

  @override
  State<PdfEditScreen> createState() => _PdfEditScreenState();
}

class _PdfEditScreenState extends State<PdfEditScreen> {
  late Uint8List pdfBytes;

  @override
  void initState() {
    super.initState();
    loadPDF().then((value) => setState(
          () => pdfBytes = value!,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
          
      Image(
        image: MemoryImage(pdfBytes),
      ),
    ]));
  }
}
