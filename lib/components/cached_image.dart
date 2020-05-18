import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({Key key, this.url, this.circular = false})
      : super(key: key);

  final String url;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: circular ? (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
      ) : null,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fadeInDuration: Duration(milliseconds: 400),
    );
  }
}
