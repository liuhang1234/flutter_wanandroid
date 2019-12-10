import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wanandroid/biz/wechatnum/bloc/WXArticleEvent.dart';
import 'package:flutter_wanandroid/biz/wechatnum/bloc/WXArticleState.dart';
import 'package:flutter_wanandroid/biz/wechatnum/bloc/WxArticleBloc.dart';
import 'package:flutter_wanandroid/common/GlobalConfig.dart';
import 'package:flutter_wanandroid/model/entity/ArticleTypeEntity.dart';
import 'package:flutter_wanandroid/model/entity/ProjectEntity.dart';
import 'package:flutter_wanandroid/res/WColors.dart';
import 'package:flutter_wanandroid/utils/ScreenUtils.dart';
import 'package:flutter_wanandroid/widget/ArticleTypeView.dart';
import 'package:flutter_wanandroid/widget/LoadMoreFooter.dart';
import 'dart:math' as Math;

import 'package:flutter_wanandroid/widget/LoadingView.dart';

class WeChatNumPage extends StatefulWidget {
  @override
  State<WeChatNumPage> createState() {
    // TODO: implement createState
    return _WeChatNumPageState();
  }
}

class _WeChatNumPageState extends State<WeChatNumPage>
    with AutomaticKeepAliveClientMixin {
  WxArticleBloc wXArticleBloc;
  List<ArticleTypeEntity> types;
  List<ProjectEntity> wXArticleDatas;
  int currentProjectPage;
  int totalProjectPage;
  int selectTypeId;
  ScrollController collaspTypeScrollController;
  bool typeIsExpanded;
  String searchKey;
  bool parentTypeIsExpanded;
  bool childTypeIsExpanded;

  ///不能直接使用[WxArticleLoading]作为是否在加载的依据
  bool isLoading = false;

  GlobalKey rootKey;
  GlobalKey typeKey;

  @override
  void initState() {
    super.initState();
    wXArticleBloc = WxArticleBloc();
    types ??= [];
    wXArticleDatas ??= [];
    currentProjectPage ??= 1;
    totalProjectPage ??= 1;
    selectTypeId = 408; //408是'鸿洋'公众号分类id
    typeIsExpanded = false;
    parentTypeIsExpanded = false;
    childTypeIsExpanded = false;
    rootKey = GlobalKey();
    typeKey = GlobalKey();
    collaspTypeScrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(child: BlocProviderTree(

      blocProviders: [
        BlocProvider<WxArticleBloc>(builder: (context) => wXArticleBloc),
      ],
      child: BlocListenerTree(
        blocListeners: [
          BlocListener<WXArticleEvent, WXArticleState>(
            bloc: wXArticleBloc,
            listener: (context, state) {
              if (state is WXArticleLoading) {
                isLoading = true;
              } else if (state is WXArticleLoaded ||
                  state is WXArticleLoadError) {
                isLoading = false;
              }

              if (state is WXArticleTypesloaded) {
                types = state.WXArticleTypes;
              } else if (state is WXArticleDatasLoaded) {
                wXArticleDatas = state.datas;
                currentProjectPage = state.curretnPage;
                totalProjectPage = state.totalPage;
              } else if (state is WXArticleCollectChanged) {
                wXArticleDatas
                    .where((e) => e.id == state.id)
                    .map((e) => e.collect = state.collect)
                    .toList();
              } else if (state is WXArticleLoadError) {
                print("WXArticleLoadError " + state.toString());
              }
            },
          )
        ],
        child: BlocBuilder<WXArticleEvent, WXArticleState>(
          bloc: wXArticleBloc,
          builder: (context, state) {
            return NotificationListener(
              onNotification: (notification) {},
              child: Stack(
                children: <Widget>[
                  NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        //确定是公众号列表发出来的滚动，而不是公众号分类栏发出来的滚动
                        if (notification.metrics.axis == Axis.vertical) {
                          //确定是否到达了底部
                          if (notification.metrics.pixels >=
                              notification.metrics.maxScrollExtent) {
                            //确定当前允许加载更多
                            if (state is WXArticleLoaded &&
                                currentProjectPage < totalProjectPage) {
                              wXArticleBloc.dispatch(
                                LoadMoreWXArticleDatas(
                                    originDatas: wXArticleDatas,
                                    id: selectTypeId,
                                    page: currentProjectPage++,
                                    searchKey: searchKey),
                              );
                            }
                            return false;
                          }
                        }
                      }
                      return false;
                    },
                    child: RefreshIndicator(
                      color: GlobalConfig.colorPrimary,
                      onRefresh: () async {
                        if (!isLoading) {
                          searchKey = null;
                          wXArticleBloc.dispatch(LoadWXArticle(selectTypeId));
                        }
                        return;
                      },
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: ClampingScrollPhysics()),
                        slivers: <Widget>[
                          //头部分类栏
                          SliverToBoxAdapter(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  WColors.theme_color,
                                  WColors.theme_color_light
                                ]),
                              ),
                              child: Text("公众号"),
                            ),
                          ),
                          //文章列表
                          SliverPadding(
                            padding: EdgeInsets.only(top: 10),
                            sliver: WXArticleList(datas: wXArticleDatas),
                          ),
                          SliverToBoxAdapter(
                            child: getLoadMoreFooter(
                              currentProjectPage < totalProjectPage,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //展开的分类
                  Positioned(
                    top: _getExpandedViewMarginTop(typeKey),
                    left: 0,
                    right: 0,
                    child: Offstage(
                      offstage: !typeIsExpanded,
                      child: AnimatedOpacity(
                        opacity: typeIsExpanded ? 1 : 0,
                        duration: Duration(milliseconds: 4000),
                        child: ArticleTypeView.expandedTypesView(
                            types: types,
                            selectId: selectTypeId,
                            onExpanded: () {
                              setState(() {
                                typeIsExpanded = false;
                              });
                            },
                            onSelected: (selectId) {
                              if (!isLoading) {
                                setState(() {
                                  typeIsExpanded = false;
                                  selectTypeId = selectId;
                                  wXArticleBloc.dispatch(
                                    LoadMoreWXArticleDatas(
                                      originDatas: [],
                                      page: 1,
                                      id: selectTypeId,
                                      searchKey: searchKey,
                                    ),
                                  );
                                });
                              }
                            }),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !isLoading,
                    child: getLoading(start: isLoading),
                  ),
                ],
              ),
            );
          },
        ),
      ),

    ));

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  double _getExpandedViewMarginTop(GlobalKey relativeViewkey) {
    if (rootKey.currentContext?.findRenderObject() == null ||
        relativeViewkey.currentContext?.findRenderObject() == null) {
      return 0.0;
    }
    RenderBox renderBox = rootKey.currentContext.findRenderObject();
    double rootGlobalY = renderBox.localToGlobal(Offset.zero).dy;
    renderBox = relativeViewkey.currentContext.findRenderObject();
    double relativeViewGlobalY = renderBox.localToGlobal(Offset.zero).dy;
    return Math.max(0.0, relativeViewGlobalY - rootGlobalY);
  }

  ///公众号列表
  Widget WXArticleList({List<ProjectEntity> datas = const []}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        ProjectEntity data = datas[index];
        return WXArticleItem(data, isLoading);
      }, childCount: datas.length),
    );
  }
}

class WXArticleItem extends StatefulWidget {
  ProjectEntity data;
  bool isLoading;

  WXArticleItem(this.data, this.isLoading);

  @override
  State<WXArticleItem> createState() {
    // TODO: implement createState
    return _WXArticleItem();
  }
}

class _WXArticleItem extends State<WXArticleItem>
    with SingleTickerProviderStateMixin {
  bool lastCollectState;
  AnimationController _collectController;
  Animation _collectAnim;

  @override
  void initState() {
    super.initState();
    _collectController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _collectController, curve: Curves.easeOut);
    _collectAnim = Tween<double>(begin: 1, end: 1.8).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    if (lastCollectState == false && lastCollectState != widget.data.collect) {
      _collectController.forward(from: 0).then((_) {
        _collectController.reverse();
      });
    }
    lastCollectState = widget.data.collect;
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 8, right: 8),
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: ScaleTransition(
                scale: _collectAnim,
                child: Icon(
                  widget.data.collect ? Icons.favorite : Icons.favorite_border,
                  color:
                      widget.data.collect ? WColors.warning_red : Colors.grey,
                  size: 24,
                ),
              ),
            ),
            onTap: () {
              print("onTap");
            },
          ),
          title: Text(
            decodeString(widget.data.title),
            style: TextStyle(fontSize: 15),
          ),
          subtitle: Row(
            children: [
              widget.data.type == 1 //目前本人通过对比json差异猜测出type=1表示置顶类型
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red[700])),
                      margin: EdgeInsets.only(right: pt(6)),
                      padding: EdgeInsets.symmetric(horizontal: pt(4)),
                      child: Text(
                        "置顶",
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    )
                  : Container(),
              widget.data.fresh
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: WColors.warning_red)),
                      margin: EdgeInsets.only(right: pt(6)),
                      padding: EdgeInsets.symmetric(horizontal: pt(4)),
                      child: Text(
                        "新",
                        style: TextStyle(
                            color: WColors.warning_red,
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    )
                  : Container(),

              ///WanAndroid文档原话：superChapterId其实不是一级分类id，因为要拼接跳转url，内容实际都挂在二级分类下，所以该id实际上是一级分类的第一个子类目的id，拼接后故可正常跳转
              widget.data.superChapterId == 294 //项目
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: WColors.theme_color_dark)),
                      margin: EdgeInsets.only(right: pt(6)),
                      padding: EdgeInsets.symmetric(horizontal: pt(4)),
                      child: Text(
                        "最新项目",
                        style: TextStyle(
                            color: WColors.theme_color_dark,
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    )
                  : Container(),
              widget.data.superChapterId == 440 //问答
                  ? Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: WColors.theme_color)),
                      margin: EdgeInsets.only(right: pt(6)),
                      padding: EdgeInsets.symmetric(horizontal: pt(4)),
                      child: Text(
                        "问答",
                        style: TextStyle(
                            color: WColors.theme_color,
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    )
                  : Container(),
              Expanded(
                child: Text(
                    '${"作者"}：${widget.data.author}  ${"时间"}：${widget.data.niceDate}'),
              ),
            ],
          ),
        ),
        Divider(
          height: 10,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _collectController.dispose();
  }

  String decodeString(String str) {
    return str
        .replaceAll('&amp;', '/')
        .replaceAll("&quot;", "\"")
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”")
        .replaceAll("<br>", "\n")
        .replaceAll("&gt;", ">")
        .replaceAll("&lt;", "<");
  }
}
