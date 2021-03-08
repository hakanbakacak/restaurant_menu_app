import 'package:flutter/material.dart';

class CustomMenuListTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final Function onTapFunc;
  const CustomMenuListTile({
    this.title,
    this.imagePath,
    this.onTapFunc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunc,
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    imagePath,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
