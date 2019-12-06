
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/biz/project/project_list/ProjectItemPage.dart';
import 'package:flutter_wanandroid/common/GlobalConfig.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyBean.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyDetailBean.dart';

import 'ProjectListContract.dart';
import 'ProjectListPresenter.dart';

class ProjectListPage extends StatefulWidget{
  final ProjectClassifyBean classifyBean;

  ProjectListPage({Key key,
    @required this.classifyBean}); // 每个分类

  @override
  State<ProjectListPage> createState() {
    // TODO: implement createState
    return _ProjectListPage();
  }

}
class _ProjectListPage extends State<ProjectListPage>
    with AutomaticKeepAliveClientMixin implements View{
  ProjectListPresenter _presenter;
  int _index = 1;
  ListView listView;
  List<ProjectClassifyDetailBean> _listData = List();


  @override
  Widget build(BuildContext context) {
    listView = ListView.builder(
        itemCount: _listData.length,
        itemBuilder: (context,itemIndex){
          if(_listData.length == 0 ||itemIndex >= _listData.length ){
            return _buildLoadMoreItem();
          } else {
            return _buildListViewItemLayout(context,itemIndex);
          }
        });
    var bodyWidget = NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
      child: RefreshIndicator(
        child: listView,
        color: GlobalConfig.colorPrimary,
        onRefresh: handleRefresh,
      ),
    );
    return Scaffold(
      body: bodyWidget,
    );
  }


  // 下拉刷新
  Future<Null> handleRefresh() async {
    _index = 1;
    _presenter.getProjectList(_index,widget.classifyBean.id);
    await Future<Null>.delayed(Duration(seconds: 3), () {
      return null;
    });
  }


  bool onScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.pixels >=
        scrollNotification.metrics.maxScrollExtent) {
      _loadNextPage();
    }
    return false;
  }
  // 加载更多
  _loadNextPage() {
    _index++;
    _presenter.getProjectList(_index,widget.classifyBean.id);
  }


  @override
  void initState() {
    super.initState();
    new ProjectListPresenter(this);
    _presenter.subscribe();
    handleRefresh();
  }
  @override
  bool get wantKeepAlive => true;

  @override
  void setPresenter(Presenter presenter) {
    _presenter = presenter;
  }

  @override
  void showProject(List<ProjectClassifyDetailBean> data) {
    setState(() {
      _listData = data;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.unsubscribe();
  }


  /// 列表
  Widget _buildListViewItemLayout(BuildContext context, int index) {
    if (null == _listData ||
        _listData.length <= 0 ||
        index < 0 ||
        index >= _listData.length) {
      return Container();
    }
    return ProjectItemPage(_listData[index]);
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


}