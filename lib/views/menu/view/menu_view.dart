import 'package:flutter/material.dart';
import 'package:restaurant_menu_app/views/menu/view/customMenuSelect.dart';
import 'package:restaurant_menu_app/views/menu/view/discountMenuView.dart';
import 'package:restaurant_menu_app/views/menu/view/food_view.dart';
import 'package:restaurant_menu_app/views/menu/viewmodel/menu_view_model.dart';
import 'package:restaurant_menu_app/core/components/customMenuListTile.dart';
import 'package:restaurant_menu_app/core/components/customAppBar.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  MenuViewModel vm = new MenuViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomAppbar(
                title: "Ana Sayfa",
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: FutureBuilder(
                      future: vm.getMenuItems("main"),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CustomMenuListTile(
                                    imagePath: "assets/" +
                                        snapshot.data[index].imagePath,
                                    title: snapshot.data[index].name,
                                    onTapFunc: () {
                                      if (vm.isCustomMenu(
                                          snapshot.data[index].name)) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DiscountMenuView();
                                          },
                                        ));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FoodView(
                                                title:
                                                    snapshot.data[index].name,
                                              ),
                                            ));
                                      }
                                    },
                                  ),
                                  Divider()
                                ],
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
