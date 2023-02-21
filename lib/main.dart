import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista_de_tarefas/shared/app_widget.dart';

void main() async {
  // * Inicializando o Hive
  await Hive.initFlutter();

  // * Abrindo a caixa onde estão os dados
  await Hive.openBox('mybox');

  runApp(const MyApp());
}
