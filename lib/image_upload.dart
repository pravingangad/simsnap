import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUpload extends StatefulWidget {
  final String loan;
  final String name;

  ImageUpload(this.loan,this.name);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File imageFile;
  _openGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = (image);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = (image);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Upload Image'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text('Gallery'),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 200,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          // If the selected image is null we show "Tap to add post image"
          child: Text(
            'No image Selected',
            style: TextStyle(color: Colors.black54),
          ));
    } else {
      return Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Image.file(
              imageFile,
              width: 300.0,
              height: 300.0,
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    _decideImageView(),
                    Center(
                      child: RaisedButton(
                        elevation: 7,
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        onPressed: () {
                          _showChoiceDialog(context);
                        },
                        child: Text('select image'),
                      ),
                    ),
                    Center(
                      child: RaisedButton(
                        elevation: 7.0,
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        onPressed: () {
                          final StorageReference firebaseStorageRef =
                              FirebaseStorage.instance.ref().child('/${widget.loan}/${widget.name}.jpg');
                          final StorageUploadTask task =
                              firebaseStorageRef.putFile(imageFile);
                          print(task);
                        },
                        child: Text('Upload'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
