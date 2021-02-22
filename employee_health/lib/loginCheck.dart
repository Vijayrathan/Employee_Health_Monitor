import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  Login(this.emp_id, this.token);

  final emp_id;
  final token;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var data;
  var decodedData;
  var passwordOriginal;

  Future<void> checkData() async {
    http.Response response = await http.get('http://10.0.2.2:5001/post/login');
    print(response.statusCode);
    data = response.body;
    decodedData = jsonDecode(data);
    passwordOriginal = decodedData[int.parse(emp_id)]['pwd'].toString();
    print(password);
    print(passwordOriginal);
    if (token.toString() == passwordOriginal) {
      await Navigator.pushNamed(context, 'third');
    } else {
      Future<void> showMyDialog() async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('INCORRECT PASSWORD!!'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Please re-enter your password to continue'),
                    Text('Would you like to approve of this message?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Re-enter'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'first');
                  },
                ),
              ],
            );
          },
        );
      }

      showMyDialog();
    }
  }

  @override
  void initState() {
    checkData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SpinKitChasingDots(
            color: Colors.greenAccent,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
