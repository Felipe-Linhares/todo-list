import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista_de_tarefas/components/dialog_box.dart';
import 'package:lista_de_tarefas/components/todo_tile.dart';
import 'package:lista_de_tarefas/data/database.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.toDoList;
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Tarefas'),
        elevation: 0,
      ),
      body: db.toDoList.isEmpty
          ? Center(child: Lottie.asset('assets/lottie/empty_list.json'))
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskComplete: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value!, index),
                  deleteFunction: () => deleteTask(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
