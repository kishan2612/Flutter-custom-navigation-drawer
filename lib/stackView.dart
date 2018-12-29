import 'package:flutter/material.dart';
import "animUtil.dart";

class MainActivity extends StatefulWidget {
  AnimationController _controller;

  MainActivity(this._controller);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  static String _superHeroName = "CaptainAmerica";

  void animate(String hero) {
    setState(() {
      _superHeroName = hero;
    });
    _startAnimation(widget._controller);
  }

  void _backViewOnClick(int position) {
    switch (position) {
      case 0:
        animate("Captain America");
        break;
      case 1:
        animate("Iron Man");
        break;
      case 2:
        animate("Thor");
        break;
      case 3:
        animate("Hulk");
        break;

      default:
    }
  }

  Widget activityContainer(BuildContext context, BoxConstraints constraint) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      child: Stack(
        children: <Widget>[
          _backView(_theme),
         _frontView()],
      ),
    );
  }

  Widget _backView(ThemeData theme) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0.0,
      ),
      backgroundColor: theme.backgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
              onPressed: () => _backViewOnClick(0),
              child: Text("Captain America", style: TextStyle(fontSize: 30)),
            ),
            MaterialButton(
              onPressed: () => _backViewOnClick(1),
              child: Text(
                "Iron Man",
                style: TextStyle(fontSize: 30),
              ),
            ),
            MaterialButton(
              onPressed: () => _backViewOnClick(2),
              child: Text(
                "Thor",
                style: TextStyle(fontSize: 30),
              ),
            ),
            MaterialButton(
              onPressed: () => _backViewOnClick(3),
              child: Text(
                "Hulk",
                style: TextStyle(fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }

/*
Frontview body is wrappped by SlideTransition and ScaleTransition.
Alignment is set to centerLeft inorder to show navigation back button.
*/

  Widget _frontView() {
    return SlideTransition(
        position: _getSlideAnimation(),
        child: ScaleTransition(
          alignment: Alignment.centerLeft,
          scale: _getScaleAnimation(),
          child: _frontViewBody(),
        ));
  }

  Widget _frontViewBody() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avengers"),
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () => _startAnimation(widget._controller),
          icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: widget._controller,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    _superHeroName,
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _startAnimation(AnimationController _controller) {
    _controller.fling(
        velocity: AnimUtil.isBackpanelVisible(widget._controller) ? -1.0 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: activityContainer,
    );
  }

/* 
FrontView Slide Animation 
*/

  Animation<Offset> _getSlideAnimation() {
    return Tween(begin: Offset(0.85, 0.0), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: widget._controller, curve: Curves.linear));
  }

/*
Front View Scale Animation
*/

  Animation<double> _getScaleAnimation() {
    return Tween(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: widget._controller, curve: Curves.linear));
  }
}
