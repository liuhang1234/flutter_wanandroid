import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wanandroid/res/WColors.dart';

Widget getLoadMoreFooter(bool hasMore,{Color color = WColors.gray_background}) {
  return Container(
    width: double.infinity,
    height: 45,
    color: color,
    alignment: Alignment.center,
    child: hasMore
        ? CupertinoActivityIndicator()
        : Text(
      "———我是有底线的———",
      style: TextStyle(color: WColors.hint_color),
    ),
  );
}