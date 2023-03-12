import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() async {
  String title = "";

  Uri uri = Uri.https('jsonplaceholder.typicode.com', '/todos');
  final response = http.get(uri);
  await response.then(
    (value) {
      if (value.statusCode == 200) {
        print('Página carregada.');

        // cria map de key (String) e value (dynamic) para armazenar JSON
        print(json.decode(value.body));
        List data = json.decode(value.body) as List;
        data.forEach((element) {
          print(element['title']);
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
