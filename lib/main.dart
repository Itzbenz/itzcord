import 'package:flutter/material.dart';

import 'Screen/LoginScreen.dart';
import 'Vars.dart';

void main() {
  runApp(OurApp());
}

class OurApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itzcord',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: null,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return const LoadingScreen();
          }),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadingScreenState();
  }
}

class RGBTween extends ColorTween {

  //0 - 1
  //start of spectrum - end of spectrum
  @override
  Color? lerp(double t) {
    int i = (t * (255 * 3)) as int;
    int r = i ~/ 255;
    int g = (i % 255) ~/ 255;
    int b = (i % 255) % 255;
    return Color.fromARGB(255, r, g, b);
  }
}

class LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Color?> _colorBreath;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _colorBreath = _animationController.drive(RGBTween());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<String>(
          stream: init(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !initialized) {
              //loading screen with text on the bottom of progress bar
              return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: _colorBreath,
                  ),
                  Text(
                    snapshot.data ?? "Done",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen.build(context);
          }
          return const Text("Loading");
        },
        ),
      );
  }
}
