import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'scr/registration.dart';
import 'scr/login.dart';
import 'scr/homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //this is for web
  if(kIsWeb){
    await Firebase.initializeApp(
options: const FirebaseOptions(
    apiKey: "AIzaSyDXAH048TJrGLT5saz1C_hd3iVJZKvkdfM", 
    appId: "1:966188227244:web:7eda43d34a74ad37dd1d09",
    messagingSenderId: "966188227244",
    projectId: "timothy26-ed3fc"
      ),
    );
  }
  //this is for android mobile
  else if(Platform.isAndroid){
    await Firebase.initializeApp(
options: const FirebaseOptions(
    apiKey: "AIzaSyDXAH048TJrGLT5saz1C_hd3iVJZKvkdfM", 
    appId: "1:966188227244:android:7eda43d34a74ad37dd1d09",
    messagingSenderId: "966188227244",
    projectId: "timothy26-ed3fc"
      ),
    );
  }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(), // Initial route is set to LoginPage
        '/registration': (context) => RegistrationPage(),
        '/home': (context) => HomePage(), // Add a route for HomePage
      },
    );
  }
}