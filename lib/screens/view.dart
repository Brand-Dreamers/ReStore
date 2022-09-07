import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:restore/components/constants.dart';

class View extends StatefulWidget {
  final DocumentInfo data;
  const View({Key? key, required this.data}) : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  late PdfControllerPinch _controller;

  @override
  void initState() {
    super.initState();
    Uint8List data = base64.decode(widget.data.data);
    _controller = PdfControllerPinch(document: PdfDocument.openData(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: backgroundColor,
          title: Text(widget.data.title),
          actions: [
            GestureDetector(
              onTap: () {}, // Download the document
              child: const Icon(
                Icons.download_rounded,
                color: buttonColor,
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: PdfViewPinch(controller: _controller),
        )));
  }
}
