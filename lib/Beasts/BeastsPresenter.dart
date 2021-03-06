import 'package:beast_keeper/Beasts/BeastsView.dart';
import 'package:beast_keeper/Models/Storage.dart';
import 'package:beast_keeper/Models/Beast.dart';

/* this class will act as a mediator between the view and data */
class BeastsPresenter {
  BeastsView _view;
  Storage _storage;

  void attachView(BeastsView _view){
    this._view = _view;
    this._storage = Storage();
  }


  void load() {
    Future <List> beastsFuture = _storage.getBeasts();

    //TODO: debug; check if beast list is being correctly retrieved
    beastsFuture.then((beasts) => {
        if (beasts != null) {
           _view.showBeasts(beasts)}
        });
  }




}