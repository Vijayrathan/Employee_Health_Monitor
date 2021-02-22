import 'package:employeehealth/main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Data extends StatefulWidget {
  Data(this.emp_id);

  final emp_id;

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  var data;
  var decodedData;
  String temperatureData = '';
  String pressureData = '';
  String respirationData = '';
  String glucoseData = '';
  String heartData = '';
  String oxygenData = '';
  String cholesterolData = '';
  final _auth = FirebaseAuth.instance;

  Future<void> getData() async {
    http.Response response =
        await http.get('http://10.0.2.2:5001/post/$emp_id/latest');
    print(response.statusCode);
    data = response.body;
    decodedData = jsonDecode(data);
    String temperature = decodedData[0]['temperature'].toString();
    String pressure = decodedData[0]['pressure'].toString();
    String respiration = decodedData[0]['respiration'].toString();
    String glucose = decodedData[0]['glucose'].toString();
    String heart = decodedData[0]['heart'].toString();
    String oxygen = decodedData[0]['oxygen'].toString();
    String cholesterol = decodedData[0]['cholestrol'].toString();
    print(oxygen);
    displayData(
        temperature: temperature,
        pressure: pressure,
        respiration: respiration,
        glucose: glucose,
        heart: heart,
        oxygen: oxygen,
        cholesterol: cholesterol);
    await Future.delayed(Duration(seconds: 30));
  }

  void displayData(
      {String temperature,
      String pressure,
      String respiration,
      String glucose,
      String heart,
      String oxygen,
      String cholesterol}) {
    setState(() {
      temperatureData = temperature;
      pressureData = pressure;
      respirationData = respiration;
      glucoseData = glucose;
      heartData = heart;
      oxygenData = oxygen;
      cholesterolData = cholesterol;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  var  count = 0;

  int  statusFn() {
    try {
      if (double.tryParse(temperatureData) > 99.0) {
        count += 1;
      } else if (double.tryParse(respirationData) > 25) {
        count += 1;
      } else if (double.tryParse(glucoseData) > 200) {
        count += 1;
      } else if (double.tryParse(heartData) > 115) {
        count += 1;
      } else if (double.tryParse(oxygenData) > 96) {
        count += 1;
      } else if (double.tryParse(cholesterolData) > 240) {
        count += 1;
      }
    } catch (E) {
      print("");
    }
    return count;
  }

  var value;

  double scaleValue() {
    try {
      if (statusFn() >= 4) {
        value = 20.0;
      } else if (statusFn() == 2) {
        value = 60.0;
      } else {
        value = 90.0;
      }
    } catch (_) {
      print(">>>");
    }
    return value;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Health Space",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.green[100],
                    fontWeight: FontWeight.w800),
              ),
              backgroundColor: Colors.indigo,
              leading: null,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Future<void> showMyDialog() async {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('YOU ARE ABOUT TO LOGOUT !!'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'Would you like to approve of this message?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    _auth.signOut();
                                    Navigator.pushNamed(context, 'first');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      showMyDialog();
                    })
              ],
            ),
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/backgroundapp.jpg'),
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.8), BlendMode.dstATop),
                      fit: BoxFit.cover),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(width: 15, color: Colors.indigo),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.whatshot),
                            Text(
                              'TEMPERATURE \n $temperatureData \n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                              ),
                            ),
                          ]),
                      padding: EdgeInsets.all(4),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(width: 15, color: Colors.indigo),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.multiline_chart),
                            Text(
                              'PRESSURE\n$pressureData',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          ]),
                      padding: EdgeInsets.all(8),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(width: 15, color: Colors.indigo),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wb_iridescent),
                            Text(
                              'RESPIRATION\n$respirationData',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            )
                          ]),
                      padding: EdgeInsets.all(8),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(width: 15, color: Colors.indigo),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.thermostat_outlined),
                            Text(
                              'GLUCOSE\n$glucoseData',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            )
                          ]),
                      padding: EdgeInsets.all(8),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(width: 15, color: Colors.indigo),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.waves),
                            Text(
                              "HEART RATE\n $heartData",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            )
                          ]),
                      padding: EdgeInsets.all(8),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(width: 15, color: Colors.indigo),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.ac_unit),
                          Text(
                            'OXYGEN  \n$oxygenData',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(8),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(width: 15, color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.pregnant_woman_outlined),
                            Text(
                              'CHOLESTEROL \n $cholesterolData',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            )
                          ]),
                      padding: EdgeInsets.all(8),
                    ),
                    SfRadialGauge(
                        title: GaugeTitle(
                            text: 'Health-o-meter',
                            textStyle: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                        axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 0,
                                    endValue: 30,
                                    color: Colors.red,
                                    startWidth: 10,
                                    endWidth: 10,
                                    label: "BAD"),
                                GaugeRange(
                                    startValue: 30,
                                    endValue: 60,
                                    color: Colors.orange,
                                    startWidth: 10,
                                    endWidth: 10,
                                    label: "AVERAGE"),
                                GaugeRange(
                                    startValue: 60,
                                    endValue: 100,
                                    color: Colors.green,
                                    startWidth: 10,
                                    endWidth: 10,
                                    label: "GOOD")
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(value: scaleValue())
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Container(
                                        child: Text('Score :20',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold))),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ]),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'medical');
                        },
                        child: Text(
                          "Upload medical documents ",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        color: Colors.indigo,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'document');
                        },
                        child: Text(
                          "View Medical records",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        color: Colors.indigo,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'stress');
                        },
                        child: Text(
                          "Manage Stress",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        color: Colors.indigo,
                      ),
                    ),

                  ],
                ))));
  }
}
