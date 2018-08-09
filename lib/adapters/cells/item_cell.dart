part of app_movie;

class ItemCell extends StatelessWidget {
  final Movie _movie;

  ItemCell(this._movie);

  @override
  Widget build(BuildContext context) {
    print(whiteTheme);
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.network(
                "http://image.tmdb.org/t/p/w342${_movie.poster_path}",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
                color: whiteTheme ? Colors.black54 : Colors.white70,
                child: Text(
                  '${_movie.title}',
                  style: TextStyle(
                      color: Utils.textTheme(),
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
