import 'package:flutter/material.dart';
import 'package:hello/screens/detail_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:hello/models/repository.dart';
import 'package:hello/components/cached_image.dart';

class ListRepository extends StatelessWidget {
  const ListRepository({Key key, this.controller, this.repositories})
      : super(key: key);

  final ScrollController controller;
  final List<Repository> repositories;

  @override
  Widget build(BuildContext context) {
    var leading = (int index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DetailImage(
                        id: repositories[index].id,
                        avatarUrl: repositories[index].avatarUrl,
                      )),
            );
          },
          child: Hero(
            tag: repositories[index].id,
            child: CachedImage(
              url: repositories[index].avatarUrl,
              circular: true,
            ),
          ),
        );

    return ListView.builder(
      controller: controller,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(repositories[index].name),
                  subtitle: repositories[index].description != null
                      ? Text(repositories[index].description)
                      : null,
                  leading: leading(index),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var url = repositories[index].url;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Url inválida $url')));
                      }
                    },
                    child: Text(
                      'Abrir repositório',
                    ),
                  ),
                ],
              ),
            ],
          ),
          elevation: 5.0,
        );
      },
      itemCount: repositories.length,
    );
  }
}
