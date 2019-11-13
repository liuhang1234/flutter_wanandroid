import 'package:flutter/material.dart';

import 'ArticleContract.dart';
import 'ArticlePresenter.dart';

class ArticlePage extends StatefulWidget {
  @override
  State<ArticlePage> createState() {
    return _ArticlePage();
  }
}

class _ArticlePage extends State<ArticlePage> implements View {
  ArticlePresenter _presenter;
  String mText = 'hahah';

  @override
  void initState() {
    super.initState();
    new ArticlePresenter(this);
    _presenter.subscribe();
    _presenter.getArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        mText,
        style: TextStyle(color: Colors.red, fontSize: 50),
      ),
    );
  }

  @override
  void setPresenter(Presenter presenter) {
    _presenter = presenter;
  }

  @override
  void showArticle(String text) {
    print(text);
    changeText(text);
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    _presenter.unsubscribe();
  }

  void changeText(String text) {
    setState(() {
      mText = text;
    });
  }
}
