import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/provider/todo_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textcontroller = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add todo list"),
            content: TextField(
              controller: _textcontroller,
              decoration: InputDecoration(hintText: "Write todo item"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_textcontroller.text.isEmpty) {
                      return;
                    }

                    context.read<TodoProvider>().addToDoList(new TODOmodel(
                        title: _textcontroller.text, isCompleted: false));
                    _textcontroller.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Submit"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            child: Center(
              child: Text(
                "TO Do List",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          )),
          Expanded(
              flex: 3,
              child: ListView.builder(
                itemBuilder: (context, itemindex) {
                  return ListTile(
                    onTap: () {
                      provider
                          .todostatuschange(provider.allTODOlist[itemindex]);
                    },
                    leading: MSHCheckbox(
                        size: 30,
                        value: provider.allTODOlist[itemindex].isCompleted,
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Colors.deepPurple,
                        ),
                        style: MSHCheckboxStyle.stroke,
                        onChanged: (slected) {
                          provider.todostatuschange(
                              provider.allTODOlist[itemindex]);
                        }),
                    title: Text(
                      provider.allTODOlist[itemindex].title,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration:
                              provider.allTODOlist[itemindex].isCompleted ==
                                      true
                                  ? TextDecoration.lineThrough
                                  : null),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          provider
                              .removeToDoList(provider.allTODOlist[itemindex]);
                        },
                        icon: Icon(Icons.delete)),
                  );
                },
                itemCount: provider.allTODOlist.length,
              ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          _showDialog();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
