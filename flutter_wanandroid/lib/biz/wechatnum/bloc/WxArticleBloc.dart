

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/biz/wechatnum/bloc/WXArticleEvent.dart';
import 'package:flutter_wanandroid/biz/wechatnum/bloc/WXArticleState.dart';
import 'package:flutter_wanandroid/http/DioManager.dart';
import 'package:flutter_wanandroid/http/httpmodel/BaseEntity.dart';
import 'package:flutter_wanandroid/model/entity/ArticleTypeEntity.dart';
import 'package:flutter_wanandroid/model/entity/BaseListEntity.dart';
import 'package:flutter_wanandroid/model/entity/ProjectEntity.dart';

class WxArticleBloc extends Bloc<WXArticleEvent,WXArticleState>{
  CancelToken _mToken = CancelToken();


  @override
  // TODO: implement initialState
  WXArticleState get initialState => WXArticleUnready();

  @override
  Stream<WXArticleState> mapEventToState(WXArticleEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadWXArticle) {
      _loadWXArticleToState(event.id,event.searchKey);
    } else if(event is LoadMoreWXArticleDatas) {
      _loadMoreWXArticleToState(datas: event.originDatas,
      id: event.id,
      page: event.page,
      searchKey: event.searchKey);

    } else if(event is CollectWXArticle) {
      _collectWXArticleToState(event.id,event.collect);
    }
  }

  Stream<WXArticleState> _loadWXArticleToState(int id, String searchKey) async* {
    try {
      yield WXArticleLoading();
      List<ArticleTypeEntity> types = await _getTypes();
      yield WXArticleTypesloaded(types);
      WXArticleDatasLoaded datasState = await _getWXArticleDatasState(
        datas: [],
        id: id,
        page: 1,
        searchKey: searchKey,
      );
      yield datasState;
      yield WXArticleLoaded();
    } catch (e) {
      yield WXArticleLoadError(e);
    }
  }

  Stream<WXArticleState> _loadMoreWXArticleToState(
      {List<ProjectEntity> datas, int id, int page, String searchKey})  async* {

  }

  Stream<WXArticleState> _collectWXArticleToState(int id, bool collect) async* {

  }


  Future<List<ArticleTypeEntity>> _getTypes() async {
    Response response = await DioManager.getInstance().getWithResponse(Api.MP_WECHAT_NAMES, token: _mToken);
    BaseEntity<List> baseEntity =  BaseEntity.fromJson(response.data);
    List<ArticleTypeEntity> parentTypes =
    baseEntity.data.map((e) => ArticleTypeEntity.fromJson(e)).toList();
    return parentTypes;
  }

  Future<WXArticleDatasLoaded> _getWXArticleDatasState({
    List<ProjectEntity> datas,
    int id,
    int page,
    String searchKey,
  }) async{
    Response response = await DioManager.getInstance().getWithResponse(Api.MP_WECHAT_NAMES, token: _mToken);
    if(searchKey != null) {
      Map<String, dynamic> query = {'k': searchKey};
      response = await DioManager.getInstance().getWithResponse(WXArticleURL(page,id,), token: _mToken,queryParameters: query);
    } else{
      response = await DioManager.getInstance().getWithResponse(WXArticleURL(page,id,), token: _mToken);
    }
    BaseEntity<Map<String, dynamic>> baseEntity =
    BaseEntity.fromJson(response.data);
    BaseListEntity<List> baseListEntity =
    BaseListEntity.fromJson(baseEntity.data);

  }


  static String WXArticleURL(int page,int id){
      return"${Api.MP_WECHAT_LIST}$page/$id";

    }

}