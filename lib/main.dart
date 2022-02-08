import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tog_technical_test/pages/home_page.dart';
import 'package:tog_technical_test/provider/db_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DbProvider(),
      child: MaterialApp(
        title: 'Tog Technical Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
