class Note {
  int _id;
  String _title;
  String _description;
  String _type;
  String _date;

  Note(this._title, this._date, this._type, [this._description]);

  Note.withId(this._id, this._title, this._date, this._type,
      [this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get type => _type;
  String get date => _date;

  set title(String nTitle) {
    if (nTitle.length <= 255) {
      this._title = nTitle;
    }
  }

  set description(String nDescription) {
    if (nDescription.length <= 255) {
      this._description = nDescription;
    }
  }

  set type(String nType) {
    this._type = nType;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['type'] = _type;
    map['date'] = _date;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._type = map['type'];
    this._date = map['date'];
  }
}
