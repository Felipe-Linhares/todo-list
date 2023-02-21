import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // * Controller do texto
  final _controller = TextEditingController();

  // * Instanciando o banco de dados
  ToDoDataBase db = ToDoDataBase();

  // * Instanciando os dados
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

  // * Alterando o status da checbox
  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // * Adicionando a tarefa no banco de dados
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // * Chamando a tela para adicionar um nova tarefa
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

  // * Deletando a tarefa
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // * Copiando texto da tarefa para a área de transferência
  void copyTask(int index, String text) {
    Clipboard.setData(ClipboardData(text: text)).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Texto copiado para a área de transferência'),
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 150,
              right: 20,
              left: 20),
        ),
      ),
    );
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
                  copyFunction: () => copyTask(index, db.toDoList[index][0]),
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
