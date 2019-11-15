import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/biz/article/ArticlePage.dart';
import 'package:flutter_wanandroid/biz/mine/MinePage.dart';
import 'package:flutter_wanandroid/biz/project/ProjectPage.dart';
import 'package:flutter_wanandroid/biz/system/SystemPage.dart';
import 'package:flutter_wanandroid/biz/wechatnum/WeChatNumPage.dart';

// 首页
class PageMain extends StatefulWidget {
  @override
  State<PageMain> createState() {
    // TODO: implement createState
    return _PageMain();
  }
}

class _PageMain extends State<PageMain> {
  Widget mainPage = ArticlePage();
  Widget projectPage = ProjectPage();
  Widget systemPage = SystemPage();
  Widget wechatPage = WeChatNumPage();
  Widget minePage = MinePage();

  PageController _pageController;

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

  // bottomnaviagtionbar 和 pageview 的联动
  void _onItemTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Scaffold(
        body: PageView(
          children: <Widget>[
            mainPage,
            projectPage,
            wechatPage,
            systemPage,
            minePage
          ],
          onPageChanged: _onPageChanged,
          controller: _pageController,
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

  _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
