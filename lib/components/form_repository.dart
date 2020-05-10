import 'package:flutter/material.dart';

import 'package:hello/components/botao.dart';

class FormRepository extends StatefulWidget {
  FormRepository({Key key, this.onSearch, this.loading}) : super(key: key);

  final Function onSearch;
  final bool loading;

  @override
  _FormRepositoryState createState() => _FormRepositoryState();
}

class _FormRepositoryState extends State<FormRepository> {
  final _formKey = GlobalKey<FormState>();

  var _search = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            onChanged: (value) => setState(() {
              _search = value;
            }),
            decoration: const InputDecoration(
              hintText: 'Busque repositórios',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor, preencha esse campo';
              }
              return null;
            },
          ),
          Botao(
            onPressed: widget.loading || _search.isEmpty
                ? null
                : () {
                    if (_formKey.currentState.validate()) {
                      widget.onSearch(_search);
                    }
                  },
            text: "Buscar",
          ),
          if (widget.loading) CircularProgressIndicator(),
        ],
      ),
    );
  }
}
