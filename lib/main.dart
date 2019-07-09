import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Munchkin Mate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _level = 0;
  int _combat = 0;
  bool _male = true;

  void _incrementCombatCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _combat++;
    });
  }

  void _decrementCombatCounter() {
    setState(() {
      _combat--;
    });
  }

  void _incrementLevelCounter() {
    setState(() {
      _level++;
    });
  }

  void _decrementLevelCounter() {
    setState(() {
      _level--;
    });
  }

  void _invertGender() {
    setState(() {
      _male = !_male;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FloatingActionButton(
                  onPressed: _invertGender,
                  child: new Icon(
                    _male ? MdiIcons.humanMale : MdiIcons.humanFemale,
                  ),
                  backgroundColor: _male ? Colors.blue : Colors.pink,
                )
              ]
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: new TextField(
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 40.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Player Name',
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text('Level',
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FloatingActionButton(
                  onPressed: _decrementLevelCounter,
                  child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                    backgroundColor: Colors.white,),
                new Text('$_level',
                    style: new TextStyle(fontSize: 60.0)),
                new FloatingActionButton(
                  onPressed: _incrementLevelCounter,
                  child: 
                    new Icon(Icons.add, color: Colors.black,),
                      backgroundColor: Colors.white,),
              ],
            ),
             new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Combat',
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new FloatingActionButton(
                  onPressed: _decrementCombatCounter,
                  child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                    color: Colors.black),
                    backgroundColor: Colors.white,),
                new Text('$_combat',
                    style: new TextStyle(fontSize: 60.0)),
                new FloatingActionButton(
                  onPressed: _incrementCombatCounter,
                  child: 
                    new Icon(Icons.add, color: Colors.black,),
                      backgroundColor: Colors.white,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
