import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/GlobalConfig.dart';
import 'package:flutter_wanandroid/model/article/ArticleDetailBean.dart';

import 'ArticleItemPage.dart';
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

class _ArticleListPage extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin
    implements View {
  ArticleListPresenter _presenter;
  int _index = 0;
  ListView listView;
  List<ArticleDetailBean> _listData = List();
  bool _haveMoreData = true;
  bool _loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new ArticleListPresenter(this);
    _presenter.subscribe();
    handleRefresh();
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
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index == 0 && null != widget.banner) {
          return widget.banner;
        } else if (index - (null == widget.banner ? 0 : 1) >=
            _listData.length) {
          return _buildLoadMoreItem();
        } else {
          return _buildListViewItemLayout(context, index);
        }
      },
    );

    var body2 = NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      // 下拉刷新控件
      child: RefreshIndicator(
        child: listView,
        color: GlobalConfig.colorPrimary,
        onRefresh: handleRefresh,
      ),
    );
//    return Scaffold(
//      resizeToAvoidBottomInset: false,
//      body: body,
//    );
    return Scaffold(
      body: body2,
    );
  }

  ScrollController _controller;

  //加载更多
  ScrollController getControllerForListView() {
    if (widget.selfControl) {
      if (null == _controller) _controller = ScrollController();
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadNextPage();
      }
      return _controller;
    } else {
      return null;
    }
  }

  void handleScroll(double offset, {ScrollController controller}) {
    ((null == controller) ? _controller : controller)?.animateTo(offset,
        duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
  }

  Future<Null> handleRefresh() async {
    _index = 0;
    _loading = true;
    _presenter.getArticleList(_index);
    await Future<Null>.delayed(Duration(seconds: 3), () {
      return null;
    });
  }

  bool onScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >=
        scrollNotification.metrics.maxScrollExtent) {
      if(!_loading){
        _loadNextPage();
      }
    }
    return true;
  }

  _loadNextPage() {
    _index++;
    _loading = true;
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
    return ArticleItemPage(_listData[index]);
  }

  @override
  void setPresenter(Presenter presenter) {
    _presenter = presenter;
  }

  @override
  void showArticle(List<ArticleDetailBean> data) {
    setState(() {
      _loading = false;
      _listData = data;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
