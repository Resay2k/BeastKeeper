/* this class will hold the scaffold and UI logic */
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';



class AddBeastView extends StatefulWidget {
  AddBeastView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() => _AddBeastViewState();
}

class _AddBeastViewState extends State<AddBeastView> {
  int _counter = 0;
  File _image;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _getImage() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Add Beast'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
            /*...*/
            },
            textColor: Colors.white,

            child: Text(
              "Save",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[

            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Stack(
                children: <Widget>[
                  _image == null
                    ? CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey,
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.white,
                          size: 80),
                        child: new Icon(Icons.image),
                      )
                    )
                    : Image.file(_image),

                  Positioned(
                      bottom: -5,
                      right:-5,
                      child: FloatingActionButton(
                        heroTag: "btn2",
                        child: Icon(Icons.add_a_photo),
                        onPressed: () {
                           _getImage();},
                      )
                  ),
                ],
                overflow: Overflow.visible,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(

                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name'
                        ),
                      ),
                    ),
                  ),

                  Expanded(child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(

                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Age'
                      ),
                    ),
                  ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(

                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Additional Info'
                ),
              ),
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
