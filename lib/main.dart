import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cargopro_intern_app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCLXUKFtBPnUStiiMfyrUec-TR8-WqnLvU", 
      appId: "1:906473184089:web:2931f66c2f75367eca4a48", 
      messagingSenderId: "906473184089", 
      projectId: "restful-api-manager", 
      
    ),
  );
  runApp(GetMaterialApp(
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}