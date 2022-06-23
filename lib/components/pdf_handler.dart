import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:pdf/widgets.dart' as PW;
import 'package:restore/components/constants.dart';

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
    _loadPDF().then((value) => pdfBytes = value);
  }

  Future<Uint8List> _loadPDF() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowedExtensions: [
      'pdf',
    ], type: FileType.custom);
    if (result != null) {
      return File(result.files.single.path as String).readAsBytesSync();
    }
    return Uint8List(0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: _loadPDF(),
            initialData: Uint8List(0),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(5, 0, 0, 0),
                          borderRadius: BorderRadius.circular(5.0)),
                      height: 250,
                      child: Center(
                          child: Text(
                              "An error occurred while opening the document",
                              style: littleHeaderTextStyle)));
                } else if (snapshot.hasData) {
                  return Image.memory(snapshot.data as Uint8List);
                } else {
                  return Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(5, 0, 0, 0),
                        borderRadius: BorderRadius.circular(5.0)),
                    height: 250,
                    child: Center(
                        child: Text("Empty Data!",
                            style: littleHeaderTextStyle)));
                }
              } else {
                return Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(5, 0, 0, 0),
                        borderRadius: BorderRadius.circular(5.0)),
                    height: 250,
                    child: Center(
                        child: Text("An error occurred!",
                            style: littleHeaderTextStyle)));
              }
            })));
  }
}
