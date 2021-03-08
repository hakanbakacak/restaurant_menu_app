import 'package:restaurant_menu_app/views/menu/model/menu_model.dart';
import 'package:restaurant_menu_app/views/menu/service/menu_service.dart';
import 'package:restaurant_menu_app/views/menu/view/customMenuSelect.dart';

class MenuViewModel {
  static MenuViewModel _instance;
  List<MenuItemModel> menuItemList = [];

  /* MenuViewModel get instance {
    if (_instance == null) {
      return new MenuViewModel();
    } else {
      return instance;
    }
  }*/
  Future getMenuItems(String menuKey) {
    return MenuService.getMenuItems(menuKey);
  }

  Future getDiscountMenuItems() async {
    return await MenuService.getMenuItemFromDiscounts();
  }

  bool isCustomMenu(String menuKey) {
    return menuKey == "İndirimli Menüler" ? true : false;
  }

  Future getFoods(String menuKey) {
    return MenuService.getFoods(menuKey);
  }

  Future getFoodsFromDiscounts(String discountMenuName) async {
    return await MenuService.getFoodsFromDiscounts(discountMenuName);
  }

  Future getSubmenus(String discountMenuName) {
    return MenuService.getSubMenu(discountMenuName);
  }
}
