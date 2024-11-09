import 'package:flutter/material.dart';
import 'package:cycle_sharing_app/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cycle Sharing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3EBACE),
        scaffoldBackgroundColor: Color(0xFF3F5F7E),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color(0xFFDBECF1)), // Adjusted color code
      ),
      home: HomeScreen(),
    );
  }
}
