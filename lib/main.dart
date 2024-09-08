import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'ReorderableList Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> fruits = [
    'apple',
    'mango',
    'banana',
    'orange',
    'cherry',
    'watermelon'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          proxyDecorator: proxyDecorator,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final oldItem = fruits.removeAt(oldIndex);
              fruits.insert(newIndex, oldItem);
            });
          },
          children: List.generate(
            fruits.length,
            (index) {
              return ListTile(
                // tileColor: Colors.lightBlue,
                key: ValueKey(fruits[index]),
                title: Text(
                  fruits[index],
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          )),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animVal = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 20, animVal)!;
        return Material(
          elevation: elevation,
          shadowColor: Colors.black,
          color: Colors.red,
          child: child,
        );
      },
      child: child,
    );
  }
}
