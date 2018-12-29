import 'package:flutter/material.dart';
import "animUtil.dart";

class MainActivity extends StatefulWidget {
  AnimationController _controller;

  MainActivity(this._controller);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  static var _superHero = "CaptainAmerica";

  void animate(String hero) {
    setState(() {
      _superHero = hero;
    });
    widget._controller.fling(
        velocity: AnimUtil.isBackpanelVisible(widget._controller) ? -1.0 : 1.0);
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
          SlideTransition(
              position: _getSlideAnimation(constraint), child: _frontView())
        ],
      ),
    );
  }

Widget _backView(ThemeData theme){
return Scaffold(
  appBar: AppBar(
    backgroundColor: theme.backgroundColor,
    elevation: 0.0,
  ),
  backgroundColor: theme.backgroundColor,
  body: Container(
    child: Center(
          child: Column(
      children: <Widget>[
         MaterialButton(
                      onPressed: () => _backViewOnClick(0),
                      child:
                          Text("Captain America", style: TextStyle(fontSize: 30)),
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
  ),
);
}

  Widget _frontView() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation"),
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () {
            widget._controller
                .fling(velocity: AnimUtil.isBackpanelVisible(widget._controller) ? -1.0 : 1.0);
          },
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
                    _superHero,
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

  Animation<Offset> _getSlideAnimation(BoxConstraints _constraints) {
    return Tween(begin: Offset(0.85, 0.0), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: widget._controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: activityContainer,
    );
  }
}
