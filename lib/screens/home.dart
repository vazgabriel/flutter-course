import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:hello/models/repository.dart';
import 'package:hello/components/form_repository.dart';
import 'package:hello/components/list_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _repositories = new List<Repository>();
  var _loading = false;

  Future<void> searchRepositories(String repo) async {
    if (_loading) return;

    setState(() {
      _loading = true;
    });

    var response = await http.get(
        "https://api.github.com/search/repositories?q=$repo&page=0&per_page=10");
    var data = jsonDecode(response.body);

    setState(() {
      _loading = false;
      _repositories =
          (data['items'] as List).map((e) => Repository.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Início"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            FormRepository(
              onSearch: searchRepositories,
              loading: _loading,
            ),
            Expanded(
              child: ListRepository(
                repositories: _repositories,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
