import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(255, 152, 0, 1),
            primary: Colors.orange,
            secondary: Colors.orange.shade300),
      ),
      home: const HomePage(),
    );
  }
}
