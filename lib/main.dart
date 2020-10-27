import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState(); 
}

class _MyAppState extends State<MyApp> {
  TextEditingController _heightctrl = new TextEditingController();
  TextEditingController _weightctrl = new TextEditingController();
  String lbm = "";
  String lbm2 = "";
  String lbm3 = "";
  AudioCache audioCache = new AudioCache();
  AudioPlayer audioPlayer = new AudioPlayer();
  int gender = 0;

  //declare int number for according gender
  void maleGender() {
    setState(() {
      gender = 0;
    });
  }

  void femaleGender() {
    setState(() {
      gender = 1;
    });
  }
  
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.greenAccent,
  ),
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Lean Body Mass Calculator'),
        ),
        
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(
                      padding: const EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: maleGender,
                      child: new Text("Male"),
                    ),
                    
                    new RaisedButton(
                      onPressed: femaleGender,
                      textColor: Colors.white,
                      color: Colors.red,
                      padding: const EdgeInsets.all(8.0),
                      child: new Text('Female'),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextField(
                    controller: _heightctrl,
                    keyboardType: TextInputType.numberWithOptions(),
                    style: new TextStyle(
                        fontSize: 22.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Height (meter)",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    style: new TextStyle(
                        fontSize: 22.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                    controller: _weightctrl,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Weight (kg)",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: new MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    elevation: 5.0,
                    minWidth: 200.0,
                    height: 50,
                    color: Colors.greenAccent,
                    child: new Text('CALCULATE LBM',
                        style:
                            new TextStyle(fontSize: 16.0, color: Colors.black)),
                    onPressed: _bmiOperation,
                  ),
                ),
                new Text(
                  "Boer Result:$lbm",
                  style: new TextStyle(
                      fontSize: 36.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Merriweather"),
                ),
                new Text(
                  "Hume Result:$lbm2",
                  style: new TextStyle(
                      fontSize: 36.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Merriweather"),
                ),
                new Text(
                  "James Result:$lbm3",
                  style: new TextStyle(
                      fontSize: 36.0,
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Merriweather"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  void _bmiOperation() {
    setState(() {
      double h = double.parse(_heightctrl.text);
      double w = double.parse(_weightctrl.text);

      if(gender == 0){
        double bresult = (0.407*w) + (0.267*h) - 19.2;
        double hresult = (0.32810*w) + (0.33929*h) - 29.5336;
        double jresult = (1.1*w) - (w/h * w/h *128);
        print(bresult);
        print(hresult);
        print(jresult);
        lbm = format(bresult);
        lbm2 = format(hresult);
        lbm3 = format(jresult);

      } else if(gender == 1){
        double bresult = (0.252*w) + (0.473*h) - 48.3;
        double hresult = (0.29569*w) + (0.41813*h) - 43.2933;
        double jresult = (1.07*w) - (w/h * w/h *148);
        print(hresult);
        print(jresult);
        lbm = format(bresult);
        lbm2 = format(hresult);
        lbm3 = format(jresult);
      }


    });
  }


  

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  Future loadOk() async {
    audioPlayer = await AudioCache().play("audio/ok.wav");
  }

  Future loadFail() async {
    audioPlayer = await AudioCache().play("audio/fail.wav");
  }

  @override
  void dispose() {
    audioPlayer = null;
    super.dispose();
  }
}
