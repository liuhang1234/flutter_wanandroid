import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wanandroid/biz/article_list/ArticleListPage.dart';
import 'package:flutter_wanandroid/model/Banner/BannerBean.dart';

import 'ArticleContract.dart';
import 'ArticlePresenter.dart';

// banner 获取
class ArticlePage extends StatefulWidget {
  @override
  State<ArticlePage> createState() {
    return _ArticlePage();
  }
}

class _ArticlePage extends State<ArticlePage> implements View {
  ArticlePresenter _presenter;
  String mText = 'hahah';
  List<BannerBean> _mBannerList;

  @override
  void initState() {
    super.initState();
    new ArticlePresenter(this);
    _presenter.subscribe();
    _presenter.getArticleList();
  }

  @override
  Widget build(BuildContext context) {
    ArticleListPage articleListPage = ArticleListPage();
    articleListPage.banner = _bannerBuild(context);
    return articleListPage;
  }

  @override
  void setPresenter(Presenter presenter) {
    _presenter = presenter;
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.unsubscribe();
  }

  void changeBanner(List<BannerBean> data) {
    setState(() {
      _mBannerList = data;
    });
  }

  @override
  void showArticle(List<BannerBean> data) {
    changeBanner(data);
  }

  // banner首页轮播
  Widget _bannerBuild(BuildContext context) {
    if (null == _mBannerList || _mBannerList.length <= 0) {
      return Center(
        child: Text('loading'),
      );
    } else {
      double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
      return Container(
        width: screenWidth,
        height: screenWidth * 500 / 900,
        child: Card(
          shape: Border(),
          margin: EdgeInsets.all(4.0),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Image.network(
                (_mBannerList[index]).imagePath,
                fit: BoxFit.fill,
              );
            },
            onTap: (index) {
              print(_mBannerList[index].toString());
            },
            itemWidth: screenWidth,
            itemHeight: screenWidth * 500 / 900,
            layout: SwiperLayout.STACK,
            itemCount: _mBannerList.length,
            pagination: SwiperPagination(alignment: Alignment(0.8, 0.8)),
            autoplay: true,
          ),
//          child: BannerView(
//            data: _mBannerList,
//            delayTime: 5,
//            scrollTime: 300,
//            buildShowView: (index, data) {
//              return Image.network((data as BannerBean).imagePath);
//            },
//          ),
        ),
      );
    }
  }
//
}
