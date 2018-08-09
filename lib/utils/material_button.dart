part of app_movie;

class MaterialButton extends StatelessWidget {
  final String text;
  final Color color;
  final GestureTapCallback onTap;

  MaterialButton({Key key, this.text, this.color, @required this.onTap}) : assert(onTap != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25.0),
          child: InkWell(
            child: Container(
              height: 50.0,
              color: color,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: Utils.textTheme(),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
