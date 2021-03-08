class FoodModel {
  String name;
  String imagePath;
  String price = "0";

  FoodModel({this.name, this.imagePath, this.price = "0"});

  FoodModel.fromJson(Map json) {
    this.name = json["name"];
    this.imagePath = json["image"];
    this.price = json["price"];
  }
}
