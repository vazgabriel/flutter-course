import 'package:flutter/material.dart';

import 'package:hello/components/botao.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _texto = "Hello World";

  @override
  void initState() => _texto = "Apos init state";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Início"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _texto,
              style: TextStyle(fontSize: 24.0),
            ),
            Botao(
              onPressed: () {
                setState(() {
                  _texto = "Novo texto";
                });
              },
              text: "Mudar Texto",
            ),
          ],
        ),
      ),
    );
  }
}
