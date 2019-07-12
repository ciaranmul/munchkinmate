import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:munchkin/PlayerCardModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Munchkin Mate',
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

class _MyHomePageState extends State<MyHomePage>{
  int cardIndex = 0;
  PageController pageController = new PageController(viewportFraction: 0.9);

  var cardList = [
    new PlayerCardModel("", true, 1, 1),
  ];

  void addPlayer(){
    setState(() {
      cardList.add(new PlayerCardModel("", true, 1, 1));
      pageController.animateToPage(
        cardList.length -1,
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 400),
        );   
    });
  }

  void incrementPlayerLevel(int index) {
    setState(() {
      cardList[index].incrementLevelCounter();
      cardList[index].incrementCombatCounter();
    });
  }

  void decrementPlayerLevel(int index) {
    setState(() {
      cardList[index].decrementLevelCounter();
      cardList[index].decrementCombatCounter();
    });
  }

  void incrementPlayerCombat(int index) {
    setState(() {
      cardList[index].incrementCombatCounter();
    });
  }

  void decrementPlayerCombat(int index) {
    setState(() {
      if(cardList[index].getCombat() > cardList[index].getLevel())
        cardList[index].decrementCombatCounter();
    });
  }

  void invertPlayerGender(int index){
    setState(() {
      cardList[index].invertGender();
    });
  }

  void removeChild(int index) {
    setState(() {
      cardList.removeAt(index);
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: PageView.builder(
                controller: pageController,
                itemCount: cardList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {  
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(  
                                  child: Icon (
                                    Icons.close,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => removeChild(position),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                  onPressed: () => invertPlayerGender(position),
                                  child: new Icon(
                                    cardList[position].isMale()? MdiIcons.humanMale : MdiIcons.humanFemale,
                                  ),
                                  backgroundColor: cardList[position].isMale() ? Colors.blue : Colors.pink,
                                ),
                              ),
                            Expanded(  
                              child: TextField(
                                controller: new TextEditingController(text: cardList[position].getName() != null ? "${cardList[position].getName()}" : ""),
                                onChanged: (text) {
                                  cardList[position].setName(text);
                                },
                                textAlign: TextAlign.center,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Player Name',
                                ),
                                style: TextStyle(
                                  fontSize: 28.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "Level",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          onPressed: () => decrementPlayerLevel(position),
                                          child: new Icon(
                                            const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                                            color: Colors.black),
                                          backgroundColor: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            "${cardList[position].getLevel()}",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          onPressed: () => incrementPlayerLevel(position),
                                          child: Icon(
                                            Icons.add, 
                                            color: Colors.black,
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded (
                                          child: Text(
                                            "Combat",
                                            style: TextStyle(
                                              fontSize: 30.0,  
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          onPressed: () => decrementPlayerCombat(position),
                                          child: new Icon(
                                            const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                                            color: Colors.black),
                                          backgroundColor: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            "${cardList[position].getCombat()}",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          onPressed: () => incrementPlayerCombat(position),
                                          child: Icon(
                                            Icons.add, 
                                            color: Colors.black,
                                          ),
                                          backgroundColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                    ),
                  );
                }, 
              ),
            ),
            FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Colors.blue,
              onPressed: addPlayer,
            ),
          ],
        ),
      ),
    );
  }
}
