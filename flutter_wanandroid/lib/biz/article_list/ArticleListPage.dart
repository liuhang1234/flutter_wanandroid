import 'package:flutter/material.dart';

class ArticleListPage extends StatefulWidget {
  Widget banner;
  String emptyMsg;

  @override
  State<ArticleListPage> createState() {
    // TODO: implement createState
    return _ArticleListPage();
  }
}

class _ArticleListPage extends State<ArticleListPage> {
  @override
  Widget build(BuildContext context) {
    if (null == widget.banner) {
      return Center();
    } else {
      return widget.banner;
    }
  }
}
