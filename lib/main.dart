import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home.dart';
import 'package:to_do_app/provider/todo_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TodoProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      )));
}
