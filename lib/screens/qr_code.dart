import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;

// ignore: camel_case_types
class QR_codePage extends StatefulWidget {
  @override
  _QR_codePageState createState() => _QR_codePageState();
}

// ignore: camel_case_types
class _QR_codePageState extends State<QR_codePage> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _inputController;
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // home: Scaffold(
      appBar: AppBar(
        title: Text("Qr_Code"),
      ),
      backgroundColor: Colors.grey[300],
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              _qrCodeWidget(this.bytes, context),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: this._inputController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) => _generateBarCode(value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.text_fields),
                        helperText:
                            'Insira seu código para gerar imagem do codigo QR.',
                        hintText: 'Por favor insira seu codigo',
                        hintStyle: TextStyle(fontSize: 15),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: this._outputController,
                      readOnly: true,
                      maxLines: 2,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.wrap_text),
                        helperText:
                            'O código de barras ou codigo QR que você digitalizar será exibido nesta área.',
                        hintText:
                            'O código de barras ou codigo QR que você digitalizar será exibido nesta área.',
                        hintStyle: TextStyle(fontSize: 15),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    this._buttonGroup(),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      // ),
    );
  }

  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.verified_user, size: 18, color: Colors.green),
                  Text('  Gerar Qrcode', style: TextStyle(fontSize: 15)),
                  Spacer(),
                  Icon(Icons.more_vert, size: 18, color: Colors.black54),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: bytes.isEmpty
                        ? Center(
                            child: Text('Código vazio ... ',
                                style: TextStyle(color: Colors.black38)),
                          )
                        : Image.memory(bytes),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Text(
                              'remover',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () =>
                                this.setState(() => this.bytes = Uint8List(0)),
                          ),
                        ),
                        Text('|',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black26)),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              final success =
                                  await ImageGallerySaver.saveImage(this.bytes);
                              SnackBar snackBar;
                              if (success) {
                                snackBar = new SnackBar(
                                    content: new Text('Salvo com sucesso!'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar = new SnackBar(
                                    content: new Text('Falha ao salvar!'));
                              }
                            },
                            child: Text(
                              'salvar',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.history, size: 16, color: Colors.black38),
                  Text('  Gerar Histórico',
                      style: TextStyle(fontSize: 14, color: Colors.black38)),
                  Spacer(),
                  Icon(Icons.chevron_right, size: 16, color: Colors.black38),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: () => _generateBarCode(this._inputController.text),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/icon/qr-code.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Gerar")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/icon/scan.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scanPhoto,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/icon/photo-scan.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan Foto")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    this._outputController.text = barcode;
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    this._outputController.text = barcode;
  }

  // ignore: unused_element
  Future _scanPath(String path) async {
    String barcode = await scanner.scanPath(path);
    this._outputController.text = barcode;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}
