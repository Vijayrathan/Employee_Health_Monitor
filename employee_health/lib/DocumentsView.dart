import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './main.dart';

class LoadImage extends StatefulWidget {
  LoadImage(this.emp_id);

  final emp_id;

  @override
  _LoadImageState createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {
  String _downloadedFile="";
  Future _getData() async {
    final ref = FirebaseStorage.instance.ref().child('images/$emp_id/image');
    var url = await ref.getDownloadURL();
    setState(() {
      _downloadedFile=url;
    });
    print(url);
    return url;
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getData() != null
                ? Image.network(
              _downloadedFile,
                fit: BoxFit.fill

            )
                : _getData(),
          ],
        ),
      ),
    );
  }
}
