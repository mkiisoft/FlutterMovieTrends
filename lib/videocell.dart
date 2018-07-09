import 'package:flutter/material.dart';

import 'video.dart';

class VideoCell extends StatelessWidget {
  final Video _video;

  VideoCell(this._video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20.0
      ),
      width: 200.0,
      height: 120.0,
      child: Stack(
        children: <Widget>[
          Image.network(
            "https://i.ytimg.com/vi/${_video.key}/hqdefault.jpg",
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.black54,
                child: Text(
                  '${_video.name}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}