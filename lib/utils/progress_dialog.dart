part of app_movie;

class ProgressDialog extends StatelessWidget {
  final Widget child;
  final bool inAsync;

  ProgressDialog({
    Key key,
    @required this.child,
    @required this.inAsync
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    widgets.add(child);

    if (inAsync) {
      final modal = Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.8,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.yellowAccent),
            ),
          )
        ],
      );
      widgets.add(modal);
    }

    return Stack(
      children: widgets,
    );
  }
}
