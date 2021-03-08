import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:restaurant_menu_app/core/components/customAppBar.dart';
import 'package:restaurant_menu_app/views/menu/viewmodel/menu_view_model.dart';

class CustomMenuSelectView extends StatefulWidget {
  String discountMenuName;
  CustomMenuSelectView({@required this.discountMenuName});

  @override
  _CustomMenuSelectViewState createState() => _CustomMenuSelectViewState();
}

class _CustomMenuSelectViewState extends State<CustomMenuSelectView> {
  MenuViewModel vm = new MenuViewModel();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(child: CustomAppbar(title: widget.discountMenuName)),
            Expanded(
              flex: 4,
              child: FutureBuilder(
                future: vm.getSubmenus(widget.discountMenuName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: vm.getFoods(snapshot.data[index]),
                          builder: (context, dropdownSnapshot) {
                            if (dropdownSnapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snapshot.data[index]),
                                      ),
                                      DirectSelect(
                                          items: List<Widget>.generate(
                                              3,
                                              (i) => DirectSelectListTile(
                                                    name: dropdownSnapshot
                                                        .data[i].name,
                                                    imagePath: "assets/" +
                                                        dropdownSnapshot
                                                            .data[i].imagePath,
                                                    price: dropdownSnapshot
                                                        .data[i].price,
                                                  )),
                                          onSelectedItemChanged: (value) {
                                            setState(() {
                                              selectedIndex = value;
                                            });
                                          },
                                          selectedIndex: selectedIndex,
                                          itemExtent: 100.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomDropdown(
                                                text: dropdownSnapshot
                                                    .data[selectedIndex].name),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        )));
  }
}

class DirectSelectListTile extends StatelessWidget {
  final name;
  final imagePath;
  final price;
  const DirectSelectListTile({
    @required this.name,
    @required this.imagePath,
    this.price,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [Text(name), price != "0" ? Text(price) : SizedBox()],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String text;
  const CustomDropdown({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_drop_down,
              ))
        ],
      ),
    );
  }
}
