import 'package:FlutterMedia/screens/initalPage.dart';
import 'package:FlutterMedia/screens/voiceRecognition.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:FlutterMedia/login.dart';
import 'package:FlutterMedia/screens/welcome.dart';
import 'package:FlutterMedia/screens/qr_code.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(
            builder: (_) => CustomSplash(
                  backGroundColor: const Color.fromARGB(255, 56, 128, 255),
                  imagePath: 'assets/img/social-media.png',
                  home: WelcomeScreen(),
                  duration: 2000,
                  type: CustomSplashType.StaticDuration,
                ));
      case '/welcome':
        return MaterialPageRoute<dynamic>(
          builder: (context) => WelcomeScreen(),
        );

      case '/initial':
        return MaterialPageRoute<dynamic>(
          builder: (context) => InitialPage(),
        );
      case '/voice':
        return MaterialPageRoute<dynamic>(
          builder: (context) => SpeechScreen(),
        );

      // *ROTA PARA A PAGINA DE LOGIN
      case '/login':
        return MaterialPageRoute<dynamic>(
          builder: (context) => Login(),
        );

      case '/qr_code':
        return MaterialPageRoute<dynamic>(
          builder: (context) => QR_codePage(),
        );

      default:
        return _erroRoute();
    }
  }

  static Route _erroRoute() => MaterialPageRoute<dynamic>(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Página de erro'),
          ),
          body: const Center(
            child: Text('Página não encontrada para a condição informada.'),
          ),
        ),
      );
}
