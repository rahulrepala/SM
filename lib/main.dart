import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:studio_management/ui/login.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff2f2d51),
        scaffoldBackgroundColor: Color(0xfff2f7ff),
        buttonColor: Color(0xff2f2d51),
        textTheme: TextTheme(
           button: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17),
        )
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

   @override
void initState(){
  super.initState();
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
}

@override
dispose(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f7ff),
      body: Center(
        child: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: Login(),
          image:Image.asset(
            'assets/images/camera.png'
          ),
          photoSize: 180,
          backgroundColor: Colors.white,
          loaderColor: Colors.red,
        ),
        )
      );
  }
}
