
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cycle Sharing Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the Cycle Sharing App"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text("login as ..."),
            ),
          ],
        ),
      ),
    );
  }
}
