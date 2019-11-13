import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/biz/article/ArticlePage.dart';

class PageMain extends StatefulWidget {
  @override
  State<PageMain> createState() {
    // TODO: implement createState
    return _PageMain();
  }
}

class _PageMain extends State<PageMain> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title: Text(
          '文章',
          style: TextStyle(color: Colors.yellow),
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.accessibility),
        title: Text(
          '项目',
          style: TextStyle(color: Colors.yellow),
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.ac_unit),
        title: Text(
          '公众号',
          style: TextStyle(color: Colors.yellow),
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.system_update),
        title: Text(
          '体系',
          style: TextStyle(color: Colors.yellow),
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        title: Text(
          '我的',
          style: TextStyle(color: Colors.yellow),
        )),
  ];
  int _selectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text('玩Android'),
        ),
        body: Center(
          child: ArticlePage(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          onTap: _onItemTap,
          currentIndex: _selectedIndex,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.lightBlue,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
