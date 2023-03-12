import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo(this.userId, this.id, this.title, this.completed);
}

void main() async {
  String title = "";

  Uri uri = Uri.https('jsonplaceholder.typicode.com', '/todos/1');
  final response = http.get(uri);
  await response.then(
    (value) {
      if (value.statusCode == 200) {
        print('Página carregada.');

        Map<String, dynamic> data = json.decode(value.body);

        Todo todo = new Todo(
            data['userId'], data['id'], data['title'], data['completed']);
        print(todo.title);

        // cria map de key (String) e value (dynamic) para armazenar JSON
        //print(json.decode(value.body));
        // List data = json.decode(value.body) as List;
        // data.forEach((element) {
        //   print(element['title']);
        // });
      } else {
        print('Erro.');
        title = "Request error.";
      }
    },
  );

  runApp(MainApp(
    title: title,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
