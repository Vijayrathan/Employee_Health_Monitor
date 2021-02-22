import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import './main.dart';

class UploadPage extends StatefulWidget {
  UploadPage(this.emp_id);

  final emp_id;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _image;
  String _uploadedFileURL;
  String url;
  final picker = ImagePicker();

  Future chooseFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future uploadFile() async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("images/$emp_id/${Path.basename("image")}");
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    await uploadTask.whenComplete(() {
      firebaseStorageRef.getDownloadURL().then((fileURL) {
        url = fileURL;
        setState(() {
          _uploadedFileURL = url;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Medical File Upload',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/backgroundapp.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.image,
                    size: 150.0,
                    color: Colors.grey,
                  ),
                ),
                _image == null
                    ? RaisedButton(
                        child: Text('Choose File'),
                        onPressed: () {
                          chooseFile();
                        },
                        color: Colors.cyan,
                      )
                    : Container(),
                _image != null
                    ? RaisedButton(
                        child: Text('Upload File'),
                        onPressed: () {
                          uploadFile();
                        },
                        color: Colors.cyan,
                      )
                    : Container(),
                Text('Uploaded Image'),
                _uploadedFileURL != null
                    ? Image.network(
                        _uploadedFileURL,
                        height: 350,
                        width: 300,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
