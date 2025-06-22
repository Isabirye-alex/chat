import 'package:chat_app/core/others/wrapper/wrapper.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Supabase.initialize(
  //   url: 'https://btmxsgcnyycloqblvgvz.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0bXhzZ2NueXljbG9xYmx2Z3Z6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA1ODA5NjIsImV4cCI6MjA2NjE1Njk2Mn0.t-j1nw8qAWiwzQd5PsWkYEUni8uhrgIwwqgGRkhnhZc',
  // );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Customize based on your UI design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        );
      },
    );
  }
}

