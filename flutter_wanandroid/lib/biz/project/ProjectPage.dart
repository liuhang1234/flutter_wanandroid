
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/biz/project/ProjectContract.dart';
import 'package:flutter_wanandroid/biz/project/ProjectPresenter.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyBean.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<ProjectPage> createState() {
    // TODO: implement createState
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin implements View {
  List<ProjectClassifyBean> tabs;// tab页标题
  TabController tabController;
  Widget tabBarBodyView;
  TabBar tabBar;
  ProjectPresenter _presenter;

  @override
  void initState() {
    super.initState();
    new ProjectPresenter(this);
    _presenter.subscribe();
    _presenter.getTab();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white70,
          appBar: tabBar,
          body: tabBarBodyView,
        )
      );
  }

  // 返回每个隐藏的菜单项
  SelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void buildTabBar() {
    tabBar = TabBar(

      controller: tabController,

      labelColor: Colors.black,
      tabs: tabs
          .map((e) =>
          Tab(
            text: e.name,

          ))
          .toList(),
      isScrollable: true,
      indicatorColor: Colors.lightBlueAccent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(color: Colors.redAccent),
      unselectedLabelStyle: TextStyle(fontSize: 16, color: Colors.greenAccent),
    );
  }

  void buildBodyView() {
    //构造 TabBarView
    tabBarBodyView = TabBarView(
      controller: tabController,
      children: tabs.map((e) {
        //创建Tab页
        return Container(
          alignment: Alignment.center,
          child: Text(
            e.name,
            textScaleFactor: 1,
          ),
        );
      }).toList(),
    );
  }

  @override
  void setPresenter(Presenter presenter) {
    _presenter = presenter;
  }

  @override
  void showTab(List<ProjectClassifyBean> data) {
    setState(() {
      tabs = data;
    });
    tabController = TabController(length: tabs.length, vsync: this);
    buildTabBar();
    buildBodyView();

  }
}


