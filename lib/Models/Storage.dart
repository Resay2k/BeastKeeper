/* This class will be used to store data locally through shared pref */
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:beast_keeper/Models/Beast.dart';

//TODO; make class singleton instead of creating multiple sharedpref instances

class Storage {
  static Storage _instance;


//  factory Storage(){
////    if (_instance == null) {
////      _instance = Storage._init();
////    }
////    return _instance;
//  }

  Storage();

//    Storage._init() {
//    prefs = SharedPreferences.getInstance();
//  }



  void saveBeast(_beast) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('beastList') == null){

      // create new list and add the beast then save
      List <dynamic> beasts = [_beast];
      String beastListJSON = jsonEncode(beasts);
      prefs.setString('beastList', beastListJSON);

    } else{
      // append beast to existing list of beasts
      List <dynamic> beasts = jsonDecode(prefs.getString('beastList'));
      beasts.add(_beast);
      String beastListJSON = jsonEncode(beasts);
      prefs.setString('beastList', beastListJSON);
    }
  }







//TODO: copy image to application directory to prevent loss
//  void saveImage(File _image) async {
////  Get directory where we can duplicate the image.
//    final Directory directory = await getApplicationDocumentsDirectory();
//    String newPath = directory.path;
//
//// Copy the file to a application document directory.
//    final fileName = basename(_image.path);
//    final File newImage = await image.copy('$newPath/$fileName');
//  }
}