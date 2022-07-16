import 'package:flutter/material.dart';
import 'LoginPage.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBQFUjgbQBYnn5CgKSaIjOoJ-LCl7zyydo',
          appId: '1:450416137402:android:cb09aaab751f451de31e83',
          messagingSenderId: '450416137402',
          projectId: 'calrorieflex'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'DoHyeonRegular'
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}