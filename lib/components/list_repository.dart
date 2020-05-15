import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:hello/models/repository.dart';

class ListRepository extends StatelessWidget {
  const ListRepository({Key key, this.repositories}) : super(key: key);

  final List<Repository> repositories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(repositories[index].name),
                  subtitle: repositories[index].description != null ? Text(repositories[index].description) : null,
                  leading: CachedNetworkImage(
                    imageUrl: repositories[index].avatarUrl,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fadeInDuration: Duration(milliseconds: 400),
                  ),
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
