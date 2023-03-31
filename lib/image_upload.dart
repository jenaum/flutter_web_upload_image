import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  List<int>? _selectdFile;
  Uint8List? _bytesDate;

  starWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          _bytesDate =
              Base64Decoder().convert(reader.result.toString().split(",").last);
          _selectdFile = _bytesDate;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  Future uploadImage() async {
    var url = Uri.parse("https://www.aumthai.com/api/saveStudent.php");
    var request = http.MultipartRequest("POST", url);
    request.files.add(
      await http.MultipartFile.fromBytes('file', _selectdFile!,
          contentType: MediaType("application", "json"),
          filename: "Any_name.jpg"),
    );
    try {
      request.send().then(
            (value) {},
          );
    } catch (e) {}
    print(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const Text('Let\'s upload image'),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.pink,
                onPressed: () {
                  starWebFilePicker();
                },
                elevation: 8,
                highlightElevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                textColor: Colors.white,
                child: Text('Select Photo'),
              ),
              Divider(
                color: Colors.teal,
              ),
              _bytesDate != null
                  ? Image.memory(
                      _bytesDate!,
                      width: 200,
                      height: 200,
                    )
                  : Container(),
              MaterialButton(
                color: Colors.purple,
                onPressed: () {
                  uploadImage();
                },
                elevation: 8,
                highlightElevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                textColor: Colors.white,
                child: Text('Send file to server'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
