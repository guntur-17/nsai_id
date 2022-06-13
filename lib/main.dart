import 'package:flutter/material.dart';
import 'package:nsai_id/providers/auth_provider.dart';
import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => OutletProvider()),
        ChangeNotifierProvider(create: (context) => DistributorProvider()),
        // ChangeNotifierProvider(create: (context) => AttedanceProvider()),

        // ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        theme: ThemeData(
          disabledColor: Colors.blue,
        ),
      ),
    );
  }
}
