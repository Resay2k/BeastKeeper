import 'package:flutter/material.dart';
import 'package:beast_keeper/AddBeast/AddBeastWidget.dart';
import 'package:beast_keeper/Beasts/BeastsView.dart';
import 'package:beast_keeper/Beasts/BeastsPresenter.dart';

class BeastsWidget extends StatefulWidget {
  final BeastsPresenter _presenter = BeastsPresenter();
  BeastsWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _BeastsWidgetState();
}

class _BeastsWidgetState extends State<BeastsWidget> implements BeastsView {
  BeastsPresenter _presenter;
  List<dynamic> _beasts;

  @override
  void initState() {
    // load function will request list beasts from sharedpref
    this.widget._presenter
        ..attachView(this)
        ..load();
  }

  // called when beasts are returned from sharedpref
  @override
  void showBeasts(beasts){
    setState(() {
      _beasts = beasts;
    });
  }

  // called when + button is pressed
  void _openAddBeastView(){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBeastWidget()),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // display text if beast list doesn't exit
        child: _beasts == null?
          Center(child: Text('You have no beasts saved. Add them by pressing the + below'))
            : ListView.builder(
            itemCount: _beasts.length,
            itemBuilder: (context, index) {
              final beast = _beasts[index];

              // show image icon, name and age of beast
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
      ),
    );
  }
}
