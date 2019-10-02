import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/utils/CustomUploadDialoge.dart';

class Helper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
   static final TextEditingController _imageName = TextEditingController();

  static Future<String> getImage(String image) async {
    StorageReference ref = FirebaseStorage.instance.ref().child(image);
    var url = await ref.getDownloadURL();
      return url.toString();
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em.trim());
  }

  static void showCupertinoDialog(String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Alert Dialog'),
            content: Text('$msg'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _dismissDialog(context);
                  },
                  child: Text('Close')),
              FlatButton(
                onPressed: () {
                  print('Informed');
                  _dismissDialog(context);
                },
                child: Text('Informed!'),
              )
            ],
          );
        });
  }

  static _dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null)
        return true;
      else {
        print(user.email.toString());
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static void uploadForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Press avatar to upload",
        description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        buttonText: "Upload",
      ),
    );
  }

//
//  Future getImage() async {
////    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
////
////    setState(() {
////      _image = image;
////      print('Image Path $_image');
////    });
//  }
//
//  Future uploadPic(BuildContext context) async {
//    String fileName = basename(_image.path);
//    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
//    setState(() {
//      print("Profile Picture uploaded");
//      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//    });
//  }


}