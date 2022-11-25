import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Column(children: [
        Padding(padding: EdgeInsets.fromLTRB(350.0, 0.0, 50.0, 0.0)),
        Text(
          "This is page 2 of 2",
          style: TextStyle(fontSize: 30),
        ),
        ElevatedButton(
            child: const Text('GOTO Home'),
            // Within the SecondRoute widget
            onPressed: () {
              Navigator.pop(context);
            }
            // Navigate back to first route when tapped.
            ),
      ]),
    );
  }
}
