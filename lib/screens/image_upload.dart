import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class ImageUpload extends StatefulWidget {
  final String loan;
  final String name;

  ImageUpload(this.loan, this.name);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  List<File> _imageList = [];

  File _image;
  _openGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _image = image;
      _imageList.add(_image);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _image = image;
      _imageList.add(_image);
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

  Future<Null> _uploadImages() async {
    _imageList.forEach((f) async {
      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('${widget.loan}')
          .child(basename(f.path));

      final StorageUploadTask imgupload = firebaseStorageRef.putFile(f);
      StorageTaskSnapshot snapshot = await imgupload.onComplete;

      if (snapshot.error == null) {
     
        final String imageUrl = await snapshot.ref.getDownloadURL();
        await Firestore.instance.collection("images").add({
          "imageurl": imageUrl,
          "name": widget.name,
          "loan": widget.loan,
          "createdAt": DateTime.now()
        });
      }

      setState(() {
        Fluttertoast.showToast(
            msg: "Image uploaded successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _imageList.length == 0
                        ? new Text('no image selected')
                        : GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0,
                            children: _imageList.map((File file) {
                              return GestureDetector(
                                onTap: () {},
                                child: new GridTile(
                                  child: new Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                ),
              ),
            ),
            Container(
              child: _imageList.length == 2
                  ? RaisedButton(
                      elevation: 4,
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      onPressed: () {
                        _uploadImages();
                      },
                      child: Text('Upload Image'),
                    )
                  : RaisedButton(
                      elevation: 4,
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child: Text('Add Image'),
                    ),
            ),
           
          ],
        ),
      ),
    );
  }
}
