import 'package:flutter/material.dart';
import 'package:nsai_id/providers/Product_provider.dart';
import 'package:nsai_id/providers/attendance_provider.dart';
import 'package:nsai_id/providers/auth_provider.dart';
import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/providers/document_provider.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
import 'package:nsai_id/providers/region_provider.dart';
import 'package:nsai_id/providers/visiting_provider.dart';
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
        ChangeNotifierProvider(create: (context) => DocumentProvider()),
        ChangeNotifierProvider(create: (context) => VisitingProvider()),
        ChangeNotifierProvider(create: (context) => DistributorProvider()),
        ChangeNotifierProvider(create: (context) => RegionProvider()),
        ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),

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
