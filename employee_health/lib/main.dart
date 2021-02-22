import 'package:flutter/material.dart';
import 'empData.dart';
import './loginCheck.dart';
import './medicalRecords.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './registeUser.dart';
import './DocumentsView.dart';
import './stressMgmt.dart';

var emp_id;
var password;
var email;
var token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'first',
    routes: {
      'first': (context) => MyApp(),
      'second': (context) => Login(emp_id, token),
      'third': (context) => Data(emp_id),
      'medical': (context) => UploadPage(emp_id),
      'register': (context) => Register(),
      'document': (context) => LoadImage(emp_id),
      'stress':(context)=>Stress(),
    },
  ));
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "HEALTH SPACE",
                style: TextStyle(
                  fontSize: 27,
                  color: Colors.white70,
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
            backgroundColor: Colors.indigo,
            elevation: 0.0,
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/backgroundapp.jpg'),
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                  fit: BoxFit.cover),
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Center(
                            child: Text(
                          "Employee ID",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                        margin: EdgeInsets.all(15.0),
                        alignment: Alignment.center),
                    Container(
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          emp_id = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Employee ID here',
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                        child: Center(
                            child: Text(
                          "Email ID",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                        margin: EdgeInsets.all(15.0),
                        alignment: Alignment.center),
                    Container(
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Email ID ',
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: Center(
                          child: Text(
                        "Token ID",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      alignment: Alignment.center,
                    ),
                    Container(
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          token = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Token here',
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: Center(
                          child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      alignment: Alignment.center,
                    ),
                    Container(
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Password here',
                        ),
                        obscureText: true,
                        style: TextStyle(fontSize: 14),
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: RaisedButton(
                        child: Text("LOGIN"),
                        onPressed: () async {
                          try {
                            final newUser =
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Navigator.pushNamed(context, 'second');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: RaisedButton(
                        child: Text("New User!! Register Here"),
                        onPressed: () {
                          Navigator.pushNamed(context, "register");
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
