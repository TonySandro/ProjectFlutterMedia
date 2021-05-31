import 'package:FlutterMedia/screens/initalPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 56, 128, 255),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Center(
              child: ListView(
            children: <Widget>[
              Image.asset(
                'assets/icon/unlock.png',
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  focusColor: Colors.black12,
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: new TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              Divider(),
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InitialPage(),
                        ))
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
