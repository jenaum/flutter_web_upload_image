import 'package:flutter/material.dart';
import 'package:flutter_web_upload_image/image_upload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Images Upload',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ImageUpload(),
    );
  }
}
