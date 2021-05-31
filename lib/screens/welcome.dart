import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class WelcomeScreen extends StatelessWidget {
  final PageController _controller = PageController();

  // ignore: close_sinks
  final StreamController<int> currentPage = StreamController.broadcast();
  WelcomeScreen({Key key}) : super(key: key);

  void navegarParaLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(children: <Widget>[
        PageIndicatorContainer(
          length: 4,
          indicatorColor: Colors.grey,
          indicatorSelectorColor: Colors.blue,
          padding: const EdgeInsets.only(bottom: 60, top: 40),
          child: PageView(
            controller: _controller,
            onPageChanged: currentPage.add,
            children: <Widget>[
              createWelcomeContainer(),
              createWelcomeFlutterContainer(),
              createWelcomeDDDContainer(),
              createWelcomeProntoContainer(context)
            ],
          ),
        ),
        StreamBuilder<int>(
            initialData: 0,
            stream: currentPage.stream,
            builder: (context, snapshot) => snapshot.data < 3
                ? Positioned(
                    right: 25,
                    top: 70,
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'PULAR',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink())
      ]),
    );
  }

  Widget createWelcomeContainer() {
    return templateWelcomePageView(
        Image.asset(
          'assets/img/social-media.png',
          height: 200,
        ),
        Text(
          'Bem vindo ao FlutterMedia',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: const [
              TextSpan(text: 'O '),
              TextSpan(
                text: 'FlutterMedia ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'é um aplicativo desenvolvido em Flutter com foco nos recursos de mídia'
                    ' como projeto pedagógico instituído por Cláudio Silva na disciplina de '
                    ' programação para dispositivos móveis.',
              ),
            ])));
  }

  Widget createWelcomeFlutterContainer() => templateWelcomePageView(
        Image.asset(
          'assets/img/slide-flutter.png',
          height: 200,
        ),
        const Text(
          'O que é Flutter?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: const [
                  TextSpan(text: 'O '),
                  TextSpan(
                    text: 'Flutter ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: 'é um SDK opensource criado pelo Google para '
                          'o desenvolvimento de aplicativos modernos e '
                          'nativos para Android, iOS, Desktop ou Web.')
                ])),
      );

  Widget createWelcomeDDDContainer() => templateWelcomePageView(
        Image.asset(
          'assets/img/interrogacao.png',
          height: 200,
        ),
        const Text(
          'O que é faz o FlutterMedia?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: const [
                  TextSpan(
                    text:
                        'A vigente aplicação dispõe do propósito de transmitir'
                        ' as funcionalidades básicas de mídia disponíveis no Flutter,'
                        ' assim como uma pequena parcela de seu potencial.',
                  )
                ])),
      );

  Widget createWelcomeProntoContainer(BuildContext context) =>
      templateWelcomePageView(
        Image.asset(
          'assets/img/slide-pronto.png',
          height: 200,
        ),
        const Text(
          'Pronto para continuar?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'CONTINUAR',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      );

  Widget templateWelcomePageView(Image image, Widget title, Widget content,
      [FlatButton flatButton]) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: image),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    title,
                    Container(
                      height: 10,
                    ),
                    content
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
