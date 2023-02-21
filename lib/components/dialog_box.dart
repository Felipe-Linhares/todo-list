import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/components/button_custom.dart';
import 'package:lottie/lottie.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Text('Nova Tarefa'),
          Lottie.asset('assets/lottie/add.json', height: 50)
        ],
      ),
      content: SizedBox(
        height: 120,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            textInputAction: TextInputAction.go,
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adicionar nova tarefa'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonCustom(
                text: 'Salvar',
                onPressed: onSave,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 8,
              ),
              ButtonCustom(
                color: Colors.red,
                text: 'Cancelar',
                onPressed: onCancel,
              )
            ],
          )
        ]),
      ),
    );
  }
}
