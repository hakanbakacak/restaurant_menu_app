import 'package:flutter/cupertino.dart';

class MenuItemModel {
  String name;
  String caption;
  String imagePath;

  MenuItemModel({@required this.name, this.caption, @required this.imagePath});

  MenuItemModel.fromJson(Map json) {
    this.name = json["name"];
    this.imagePath = json["image"];
    this.caption = json["caption"];
  }
}
