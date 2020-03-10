/* this class will hold the scaffold and UI logic */
import 'package:flutter/material.dart';
import 'package:beast_keeper/AddBeast/AddBeastPresenter.dart';
import 'package:beast_keeper/AddBeast/AddBeastView.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class AddBeastWidget extends StatefulWidget {
  final AddBeastPresenter _presenter = AddBeastPresenter();

  AddBeastWidget({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() => _AddBeastWidgetState();
}

class _AddBeastWidgetState extends State<AddBeastWidget>
  implements AddBeastView {

  File _image;
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _info = TextEditingController();
  bool _nameError = false;
  bool _ageError = false;
  bool _infoError = false;


  @override
  void initState() {
    this.widget._presenter.attachView(this);
  }

  @override
  void doNothing(){}

  // response to
  void _getImage() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    });
  }


  void _saveBeast(){
    setState(() {
      // show error if text-box is empty
      _name.text.isEmpty ? _nameError = true : _nameError = false;
      _age.text.isEmpty ? _ageError = true : _ageError = false;
      _info.text.isEmpty ? _infoError = true : _infoError = false;
    });

    // create new beast
    if(!_nameError && !_ageError && !_infoError){
      this.widget._presenter.newBeast(
          _name.text,
          _age.text,
          _info.text,
          _image.path);
    }

    Navigator.pop(context);
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
              _saveBeast();
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
                    : CircleAvatar(
                      radius:80,
                      backgroundImage: FileImage(_image),
                    ),

                  Positioned(
                      bottom: -1,
                      right:-1,
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
                        controller: _name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            errorText: _nameError ? 'Value can\'t be empty' : null

                        ),
                      ),
                    ),
                  ),

                  Expanded(child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _age,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Age',
                          errorText: _ageError ? 'Value can\'t be empty' : null
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
                controller: _info,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Additional Info',
                    errorText: _infoError ? 'Value can\'t be empty' : null
                ),
              ),
            ),
          ]
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        heroTag: "btn1",
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
