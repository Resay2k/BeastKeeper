/* this class will hold the scaffold and UI logic */
import 'package:flutter/material.dart';
import 'package:beast_keeper/AddBeast/AddBeastPresenter.dart';
import 'package:beast_keeper/AddBeast/AddBeastView.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class AddBeastWidget extends StatefulWidget {
  final AddBeastPresenter _presenter = AddBeastPresenter();

  AddBeastWidget({Key key, this.title}) : super(key: key);

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

  // called when add image button is pressed and only gets image from gallery
  void _getImage() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          _image = image;
        });
      }
    });
  }

  // checks for empty boxes then saves and navigates to home widget
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

    // go back to main widget
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
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
        child: Column(
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
    );
  }
}
