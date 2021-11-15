import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();

  void processNumber() {
    final int? inputValue = int.tryParse(controller.text);
    bool isCube = false;
    bool isSquare = false;

    if (inputValue == null) {
      return;
    }

    if (valueIsSquare(inputValue)) {
      isSquare = true;
    }

    if (valueIsCube(inputValue)) {
      isCube = true;
    }

    if (isSquare && isCube) {
      openDialog(inputValue, isSquare: isSquare, isCube: isCube);
    } else if (isSquare) {
      openDialog(inputValue, isSquare: isSquare);
    } else if (isCube) {
      openDialog(inputValue, isCube: isCube);
    } else {
      openDialog(inputValue);
    }
  }

  bool valueIsSquare(int value) {
    return sqrt(value) % 1 == 0;
  }

  bool valueIsCube(int value) {
    int i = 1;
    int? cubeNumber = 1;
    while (i < value) {
      cubeNumber = pow(i, 3) as int?;
      if (cubeNumber == value) {
        return true;
      }
      i = i + 1;
    }

    return false;
  }

  void openDialog(int value, {bool isSquare = false, bool isCube = false}) {
    String textToShow = '';

    if (isSquare && isCube) {
      textToShow = 'Number $value is both SQUARE and CUBE.';
    } else if (isSquare) {
      textToShow = 'Number $value is a perfect SQUARE.';
    } else if (isCube) {
      textToShow = 'Number $value is a CUBE.';
    } else {
      textToShow = 'Number $value is neither SQUARE neither CUBE.';
    }

    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(20.0),
            title: Text('$value'),
            children: <Widget>[
              Text(
                textToShow,
              ),
            ],
          );
        }).then((value) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Number shapes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Please input a number to see if it is a perfect square or a cube.',
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => processNumber,
        tooltip: 'Increment',
        child: const Icon(Icons.done),
      ),
    );
  }
}
