import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<ProjectPage> createState() {
    // TODO: implement createState
    return _ProjectPageState();
  }
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List tabs = ["首页", "发现", "我的", "设置"];
  TabController tabController;
  Widget tabBarBodyView;
  TabBar tabBar;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    buildTabBar();
    buildBodyView();
  }

//  @override
//  void didChangeDependencies() {
//    ///在initState之后调 Called when a dependency of this [State] object changes.
//    super.didChangeDependencies();
//  }

  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('项目'),
//        bottom: tabBar,
//      ),
//      body: tabBarBodyView,
//    );
    return DefaultTabController(
      length: tabs.length,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  expandedHeight: 240,
                  pinned: true,
                  primary: true,
                  title: Text("项目"),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      "images/1111.jpg",
                      fit: BoxFit.cover,
                    ),
                    collapseMode: CollapseMode.none,
                  ),
                  bottom: tabBar,
                ),
              )
            ];
          },
          body: tabBarBodyView),
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
      tabs: tabs
          .map((e) => Tab(
                text: e,
              ))
          .toList(),
      isScrollable: true,
      indicatorColor: Colors.lightBlueAccent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
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
            e,
            textScaleFactor: 1,
          ),
        );
      }).toList(),
      //创建Tab页
//      children: tabs.map((e) {
//        return Container(
//          alignment: Alignment.center,
//          child: Text(e, textScaleFactor: 1),
//        );
//      }).toList(),
    );
  }
}

/*
 actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            tooltip: '搜索',
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
            tooltip: '添加',
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.SelectView(Icons.message, '发起群聊', 'A'),
              this.SelectView(Icons.group_add, '添加服务', 'B'),
              this.SelectView(Icons.cast_connected, '扫一扫码', 'C'),
            ],
            onSelected: (action) {
              switch (action) {
                case 'A':
                  break;
                case 'B':
                  break;
                case 'C':
                  break;
              }
            },
          )
        ],
 */
