// import 'dart:html';

import 'package:FlutterMedia/screens/qr_code.dart';
import 'package:FlutterMedia/screens/voiceRecognition.dart';
import 'package:FlutterMedia/screens/camera.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GridView.count(
          crossAxisCount: 1,
          padding: EdgeInsets.fromLTRB(0, 110, 0, 0),
          childAspectRatio: 3,
          mainAxisSpacing: 15,
          children: <Widget>[
            Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: myGridItems("Câmera e Galeria", "Tire fotos e armazene ",
                    "assets/img/photography.jpg", 0xC539EE51, 0xC9FF7D32),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpeechScreen()));
              },
              child: myGridItems("Conversor de voz", "Converta voz em texto",
                  "assets/img/microphone.png", 0xE344DFB1, 0xD80B4B24),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QR_codePage()));
              },
              child: myGridItems("Scanner", "Scannear e criar qrCodes",
                  "assets/img/qrcode.png", 0xCC1696FF, 0xC5EE259A),
            ),
          ],
        ),
      ),
    );
  }

  Widget myGridItems(String gridName, String description, String gridimage,
      int color1, int color2) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: new LinearGradient(
          colors: [
            Color(color1),
            Color(color2),
          ],
          begin: Alignment.centerLeft,
          end: new Alignment(1, 1),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                image: DecorationImage(
                  image: AssetImage(gridimage),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    gridName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(
                      description,
                      style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 16),
                    )),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
