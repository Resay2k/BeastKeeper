import 'package:flutter/material.dart';
import 'package:beast_keeper/AddBeast/AddBeastWidget.dart';
import 'package:beast_keeper/Beasts/BeastsView.dart';
import 'package:beast_keeper/Beasts/BeastsPresenter.dart';
import 'package:beast_keeper/Models/Beast.dart';

class BeastsWidget extends StatefulWidget {
  final BeastsPresenter _presenter = BeastsPresenter();
  BeastsWidget({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() => _BeastsWidgetState();
}

class _BeastsWidgetState extends State<BeastsWidget> implements BeastsView {
  BeastsPresenter _presenter;
  List<dynamic> _beasts;

  @override
  void initState() {
    this.widget._presenter
        ..attachView(this)
        ..load();
  }


  @override
  void showBeasts(beasts){
    setState(() {
      _beasts = beasts;
    });
  }

  void _openAddBeastView(){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBeastWidget()),
    );

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _beasts == null?
          Center(child: Text('You have no beasts saved. Add them by pressing the + below'))
            : ListView.builder(
            itemCount: _beasts.length,
            itemBuilder: (context, index) {
              final beast = _beasts[index];

              return ListTile(
                title: Text(
                  beast['name'],
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  beast['age'],
                ),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: Image.asset(beast['imagePath'], fit: BoxFit.cover),
                ),
              );
            }),

       ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddBeastView,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
