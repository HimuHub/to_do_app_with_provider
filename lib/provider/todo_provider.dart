import 'package:flutter/material.dart';
import 'package:to_do_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TODOmodel> _todolist = [];

  List<TODOmodel> get allTODOlist => _todolist;

  void addToDoList(TODOmodel todomodel) {
    _todolist.add(todomodel);
    notifyListeners();
  }

  void todostatuschange(TODOmodel todOmodel) {
    final index = _todolist.indexOf(todOmodel);
    _todolist[index].toggleCompleted();
    notifyListeners();
  }

  void removeToDoList(TODOmodel todomodel) {
    final index = _todolist.indexOf(todomodel);
    _todolist.removeAt(index);
    notifyListeners();
  }
}
