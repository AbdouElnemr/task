import 'dart:io';

 import 'package:flutter/material.dart';
import 'package:task/utils/Helper.dart';

import 'HomePage.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement build
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.grey[300],

      appBar: AppBar(
        title: Text("Task"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      // resizeToAvoidBottomPadding: true,
      body: Container(
          child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(

              ),
            ),
            Container(
              child: Card(
                color: Colors.grey[300],
                margin: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 180.0, bottom: 150.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                child: Padding(
                  padding: new EdgeInsets.all(25.0),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: "Email ",
                                    icon: Icon(Icons.email),
                                    hintText: "Eg : test@test.com"),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  } else if (!Helper.isEmail(value)) {
                                    return 'Enter avalid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(padding: new EdgeInsets.only(top: 10.0)),
                            Container(
                              child: TextFormField(
                                controller: _passwordController,
                                // keyboardType: TextInputType.,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Password ",
                                    icon: Icon(Icons.vpn_key),
                                    hintText: "Eg : **********"),

                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "password Can't be Empty";
                                  } else if (value.length < 6) {
                                    return "Your Password is weak";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(padding: new EdgeInsets.only(top: 30.0)),
                            RaisedButton(
                              color: Colors.blue,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              padding: new EdgeInsets.all(16.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    'Login',
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              onPressed: () async {
                                try {
                                  final result = await InternetAddress.lookup('google.com');
                                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

                                    if (_formKey.currentState.validate()) {
                                      bool isLogin = await Helper.signInWithEmail(
                                          _emailController.text.trim().toString(),
                                          _passwordController.text.trim().toString());

                                      if (isLogin) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      } else {
                                        Helper.showCupertinoDialog(
                                            "\nUnsuccessful Login, email or password \n may be uncorrect",
                                            this.context);
                                      }
                                    }
                                    print('connected');
                                  }
                                } on SocketException catch (_) {
                                  print('not connected');
                                  Helper.showCupertinoDialog(
                                      "\nPlease check your internet connection",
                                      this.context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
//
    );
  }


}
