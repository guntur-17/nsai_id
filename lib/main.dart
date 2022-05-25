import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     // ChangeNotifierProvider(create: (context) => AuthProvider()),
        //   ],
        //   child: const
        MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
    // );
  }
}
