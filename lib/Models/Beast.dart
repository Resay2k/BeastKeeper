/* class to represent beast obj */
class Beast {
  String _name;
  String _age;
  String _info;
  String _imagePath;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get age => _age;

  set age(String value) {
    _age = value;
  }

  String get info => _info;

  set info(String value) {
    _info = value;
  }


  String get imagePath => _imagePath;

  set imagePath(String value) {
    _imagePath = value;
  }


  Beast();

  Map<String, dynamic> toJson() =>
      {
        'name': _name,
        'age': _age,
        'info': _info,
        'imagePath': _imagePath
      };

  Beast.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _age = json['age'],
        _info = json['info'],
        _imagePath = json['imagePath'];

}
