import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Todos {
  List todos = [];

  Todos(this.todos);
}

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  // usamos o factory para mapear um JSON para Todo
  factory Todo.fromJson(Map json) {
    return Todo(json['userId'], json['id'], json['title'], json['completed']);
  }

  // transformar Classe novamente em JSON
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'completed': completed,
      };
}

void main() async {
  String title = "";

  Uri uri = Uri.https('jsonplaceholder.typicode.com', '/todos/');
  final response = http.get(uri);
  await response.then(
    (value) {
      if (value.statusCode == 200) {
        print('Página carregada.');

        var list = json.decode(value.body) as List;
        list.forEach((element) {
          //print(element);
        });

        var todosList = Todos(list);
        todosList.todos.forEach((element) {
          Todo todo = Todo.fromJson(element);
          print(todo.title);
        });
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
