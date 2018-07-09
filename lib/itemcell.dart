import 'package:flutter/material.dart';

import 'movie.dart';

class ItemCell extends StatelessWidget {
  final Movie _movie;

  ItemCell(this._movie);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          "http://image.tmdb.org/t/p/w342${_movie.poster_path}",
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 10.0,
              ),
              color: Colors.black54,
              child: Text(
                '${_movie.title}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0),
              ),
            ),
          ],
        )
      ],
    );
  }
}