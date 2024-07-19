import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination_example/pagination_with_set_state/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListScreen(),
    );
  }
}