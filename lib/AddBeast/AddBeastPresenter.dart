/* this class will act as a mediator between the view and data */
import 'package:beast_keeper/AddBeast/AddBeastView.dart';
import 'package:beast_keeper/Models/Beast.dart';
import 'package:beast_keeper/Models/Storage.dart';
import 'dart:io';


class AddBeastPresenter {
  AddBeastView _view;

  void attachView(AddBeastView _view){
    this._view = _view;
  }

  void newBeast(String _name,String _age, String _info, String _imagePath){
    Beast beast = Beast()
        ..name = _name
        ..age = _age
        ..info = _info
        ..imagePath = _imagePath;

    Storage().saveBeast(beast);
  }
}