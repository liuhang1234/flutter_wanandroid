import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/GlobalConfig.dart';
import 'package:flutter_wanandroid/model/article/ArticleDetailBean.dart';

import 'ArticleListContract.dart';
import 'ArticleListPresenter.dart';

class ArticleListPage extends StatefulWidget {
  Widget banner;
  String emptyMsg;
  bool selfControl = true;

  @override
  State<ArticleListPage> createState() {
    // TODO: implement createState
    return _ArticleListPage();
  }
}

class _ArticleListPage extends State<ArticleListPage> implements View {
  ArticleListPresenter _presenter;
  int _index = 0;
  ListView listView;
  List<ArticleDetailBean> _listData = List();
  double _screenHeight;
  var _haveMoreData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new ArticleListPresenter(this);
    _presenter.subscribe();
    _presenter.getArticleList(_index);
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    var itemCount = ((null == _listData) ? 0 : _listData.length) +
        (null == widget.banner ? 0 : 1) +
        (_haveMoreData ? 1 : 0);
    if (itemCount <= 0) {
      return Container(
        child: Text('nodata'),
      );
    }
    listView = ListView.builder(
      controller: getControllerForListView(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == 0 && null != widget.banner) {
          return widget.banner;
        } else if (index - (null == widget.banner ? 0 : 1) >=
            _listData.length) {
          return _buildLoadMoreItem();
        } else {
          _buildListViewItemLayout(context, index);
        }
      },
    );

    var body = NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      child: RefreshIndicator(
        child: listView,
        color: GlobalConfig.colorPrimary,
        onRefresh: handleRefresh,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body,
    );
  }

  ScrollController _controller;

  ScrollController getControllerForListView() {
    if (widget.selfControl) {
      if (null == _controller) _controller = ScrollController();
      return _controller;
    } else {
      return null;
    }
  }

  void handleScroll(double offset, {ScrollController controller}) {
    ((null == controller) ? _controller : controller)?.animateTo(offset,
        duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
  }

  handleRefresh() {
    _index = 0;
    _presenter.getArticleList(_index);
  }

  bool onScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >=
        scrollNotification.metrics.maxScrollExtent) {
      _loadNextPage();
    }
    if (null == _screenHeight || _screenHeight <= 0) {
      _screenHeight = MediaQueryData.fromWindow(ui.window).size.height;
    }
    if (scrollNotification.metrics.axisDirection == AxisDirection.down &&
        _screenHeight >= 10 &&
        scrollNotification.metrics.pixels >= _screenHeight) {
      return true;
    } else {}
    return false;
  }

  _loadNextPage() {
    _index++;
    _presenter.getArticleList(_index);
  }

  ///加载更多
  Widget _buildLoadMoreItem() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Loading ..."),
      ),
    );
  }

  /// 列表
  Widget _buildListViewItemLayout(BuildContext context, int index) {
    if (null == _listData ||
        _listData.length <= 0 ||
        index < 0 ||
        index >= _listData.length) {
      return Container();
    }
  }

  @override
  void setPresenter(Presenter presenter) {
    // TODO: implement setPresenter
    _presenter = presenter;
  }

  @override
  void showArticle(List<ArticleDetailBean> data) {
    setState(() {
      _listData = data;
    });
  }
}
