import 'package:flutter/material.dart';
import 'package:restaurant_menu_app/core/components/customAppBar.dart';
import 'package:restaurant_menu_app/views/menu/viewmodel/menu_view_model.dart';

class FoodView extends StatefulWidget {
  String title;
  FoodView({@required this.title});
  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  MenuViewModel vm = MenuViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: CustomAppbar(
                title: widget.title,
              )),
              Expanded(
                  flex: 4,
                  child: Container(
                    child: FutureBuilder(
                      future: vm.getFoodsFromDiscounts(widget.title),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Image.asset("assets/" +
                                          snapshot.data[index].imagePath),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(snapshot.data[index].name),
                                          IconButton(
                                              icon: Icon(Icons.account_box),
                                              onPressed: null)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ))
            ],
          ),
        ));
  }
}
