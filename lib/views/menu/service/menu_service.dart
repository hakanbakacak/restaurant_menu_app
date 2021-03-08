import 'package:restaurant_menu_app/views/menu/model/food_model.dart';
import 'package:restaurant_menu_app/views/menu/model/menu_model.dart';
import 'package:yaml/yaml.dart';
import "package:flutter/services.dart" as s;

class MenuService {
  static MenuService _instance;
  List<MenuService> menuItemList = [];

  MenuService get instance {
    if (_instance == null) {
      return new MenuService();
    } else {
      return instance;
    }
  }

  static Future getMenuItemFromDiscounts() async {
    final data = await s.rootBundle.loadString('assets/menu.yaml');
    final mapData = loadYaml(data);
    var mainMenu;
    for (var i = 0; i < mapData["menus"].length; i++) {
      if (mapData["menus"][i]["key"] == "main") {
        mainMenu = mapData["menus"][i];
      }
    }
    var discountedMenu = mainMenu["items"][0];

    List<MenuItemModel> menuItemList = [];
    for (var i = 0; i < discountedMenu["items"].length; i++) {
      menuItemList.add(MenuItemModel.fromJson(discountedMenu["items"][i]));
    }
    return menuItemList;
  }

  static Future getFoodsFromDiscounts(String discountMenuName) async {
    final data = await s.rootBundle.loadString('assets/menu.yaml');
    final mapData = loadYaml(data);
    dynamic discountMenusMap;
    for (var i = 0; i < mapData["menus"].length; i++) {
      if (mapData["menus"][i]["key"] == "main") {
        discountMenusMap = mapData["menus"][i];
      }
    }
    print("discount menu map");
    print(discountMenusMap);
    dynamic menusMap;
    for (var i = 0; i < discountMenusMap.length; i++) {
      if (discountMenusMap["items"][i]["name"] == discountMenuName) {
        menusMap = discountMenusMap["items"][i];
      }
    }
    print("menusMap");
    print(menusMap);
    /*dynamic foodsMap;
    for (var i = 0; i < menusMap.length; i++) {
      if (discountMenusMap["items"][i]["name"] == discountMenuName) {
        foodsMap = discountMenusMap["items"][i];
      }
    }
    print("foodsMap");
    print(foodsMap);*/
    var foodList = [];
    for (var i = 0; i < menusMap.length; i++) {
      foodList.add(FoodModel.fromJson(menusMap["items"][i]));
      //print(temp.name);
    }
    print("aaaaaaaaaaaaaaaaaaaaaaaaaa");
    return foodList;
  }

  //returns FoodModel list as a menu key
  static Future getFoods(String menuKey) async {
    List<FoodModel> foodList = [];
    if (menuKey == "main") {
      return foodList;
    }

    final data = await s.rootBundle.loadString('assets/menu.yaml');
    final mapData = loadYaml(data);
    var foodsMap; // = mapData[menuKey]["items"];
    for (var i = 0; i < mapData["menus"].length; i++) {
      if (mapData["menus"][i]["key"] == menuKey) {
        foodsMap = mapData["menus"][i];
      }
    }

    for (var i = 0; i < foodsMap.length; i++) {
      FoodModel temp = FoodModel(
        name: foodsMap["items"][i]["name"],
        imagePath: foodsMap["items"][i]["image"],
      );
      foodList.add(temp);
    }
    return foodList;
  }

  //it returns list which contains discount menu's submenus
  static Future getSubMenu(String discountMenuName) async {
    List<String> foodList = [];

    final data = await s.rootBundle.loadString('assets/menu.yaml');
    final mapData = loadYaml(data);
    var subMenuItemsMap; // = mapData[menuKey]["items"];
    for (var i = 0; i < mapData["menus"].length; i++) {
      if (mapData["menus"][i]["key"] == "main") {
        subMenuItemsMap = mapData["menus"][i];
      }
    }
    var discountMenu;
    for (var i = 0; i < subMenuItemsMap.length; i++) {
      if (subMenuItemsMap["items"][i]["name"] == "İndirimli Menüler") {
        discountMenu = subMenuItemsMap["items"][i];
      }
    }
    var subMenuList;
    for (var i = 0; i < discountMenu.length; i++) {
      if (discountMenu["items"][i]["name"] == discountMenuName) {
        subMenuList = discountMenu["items"][i]["subMenus"];
      }
    }
    for (var i = 0; i < subMenuList.length; i++) {
      foodList.add(subMenuList[i]);
    }

    return foodList;
  }

  static Future getMenuItems(String menuKey) async {
    final data = await s.rootBundle.loadString('assets/menu.yaml');
    final mapData = loadYaml(data);
    var mainMenu;
    for (var i = 0; i < mapData["menus"].length; i++) {
      if (mapData["menus"][i]["key"] == menuKey) {
        mainMenu = mapData["menus"][i];
      }
    }

    List<MenuItemModel> menuItemList = List<MenuItemModel>();
    for (var i = 0; i < mainMenu["items"].length; i++) {
      menuItemList.add(MenuItemModel.fromJson(mainMenu["items"][i]));
    }

    return menuItemList;
  }
}
