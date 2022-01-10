
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouting/nickname.dart';
import 'package:scouting/statewidget.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  StateWidget stateWidget = new StateWidget(
    child: new MyApp(),
  );
  

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      runApp(stateWidget);
    });
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Scouting',
      debugShowCheckedModeBanner: false,
      home: NicknamePage(),
    
  
    );
  }
}






