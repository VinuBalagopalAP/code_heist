import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_api/screens/home.dart';
import 'package:http/http.dart' as http;

import 'package:github_api/models/repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

Future<All> fetchRepos() async {
  final response = await http
      .get(Uri.parse("https://api.github.com/users/VinuBalagopalAP/repos"));

  if (response.statusCode == 200) {
    print(response.body);
    return All.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch repos!');
  }
}
