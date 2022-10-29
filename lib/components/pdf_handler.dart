import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class PDFData {
  Uint8List? data;
  String filename;
  String encodedData;
  String documentId;

  PDFData({this.data, this.filename = "", this.encodedData = "", this.documentId = ""});
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

bool hasUserData() {
  Future<Directory> directory = getApplicationDocumentsDirectory();
  directory.then((value) {
    return File("${value.path}/data.drmr").exists();
  });
  return false;
}

void saveUserData(String email, String password) {
  Future<Directory> directory = getApplicationDocumentsDirectory();
  directory.then((value) {
    File userData = File("${value.path}/data.drmr");
    userData.writeAsStringSync("$email $password", flush: true);
  });
}

List<String> loadUserData() {
  List<String> res = [];
  Future<Directory> directory = getApplicationDocumentsDirectory();
  directory.then((value) {
    File userData = File("${value.path}/data.drmr");
    String data = userData.readAsStringSync();
    int index = data.indexOf(" ");
    res.add(data.substring(0, index));
    res.add(data.substring(index + 1));
  });

  return res;
}
