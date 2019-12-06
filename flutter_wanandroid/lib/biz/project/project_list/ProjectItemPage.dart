
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/api/Api.dart';
import 'package:flutter_wanandroid/common/GlobalConfig.dart';
import 'package:flutter_wanandroid/model/project/ProjectClassifyDetailBean.dart';
import 'package:flutter_wanandroid/utils/StringUtil.dart';
import 'package:flutter_wanandroid/widget/StrokeWidget.dart';

class ProjectItemPage extends StatelessWidget{
  final ProjectClassifyDetailBean item;

  // ignore: non_constant_identifier_names
  static final String TAG = "ProjectItemPage";

  ProjectItemPage(this.item);

  @override
  Widget build(BuildContext context) {
    item.title = StringUtil.strClean(item.title);
    item.desc = (null == item.desc) ? "" : StringUtil.strClean(item.desc);
    return GestureDetector(
      onTap: (){
        print(TAG);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 2.5),// 左右边距 上下边距
        child: Card(// 用cardview包裹
        shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(5.0)),// 圆角
          elevation: 5.0,//阴影
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),// 内边距
            child: buildItem(item),
          ),
        ),

      ),
    );
  }
  Widget buildItem(ProjectClassifyDetailBean item) {
    var widget = (null != item.envelopePic &&
        item.envelopePic.isNotEmpty &&
        !item.envelopePic.endsWith(Api.DEFAULT_PROJECT_IMG)) //默认图片就不显示了
        ?
    Row(                          // Row 水平排列 三木运算符
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: _buildItemLeftSide(item),
        ),
        Container(
          width: 30.0,
          child: Image.network(item.envelopePic),
        )
      ],
    )
        : _buildItemLeftSide(item);
    return widget;
  }

  Widget _buildItemLeftSide(ProjectClassifyDetailBean item) {
    return Column( // 垂直排列
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildItemLeftColumns(item),
    );
  }

  List<Widget> _buildItemLeftColumns(ProjectClassifyDetailBean item) {
    List<Widget> list = List();
    list.add(Text(
      item.title,
      style: TextStyle(
          fontSize: 16.0,
          color: GlobalConfig.color_black,
          fontWeight: FontWeight.w500),
      textAlign: TextAlign.left,
    ));
    if (item.desc.length > item.title.length) {
      list.add(Text(
        item.desc,
        maxLines: 3,
        style: TextStyle(color: GlobalConfig.color_dark_gray, fontSize: 13.0),
      ));
    }
    var author = item.author;
    if (null != author && author.length > 0) {
      author = "@$author";
    } else
      author = "";
    list.add(Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.timer,
            size: 13.0,
            color: GlobalConfig.color_dark_gray,
          ),
          Text(" ${item.niceDate} $author",
              style: TextStyle(
                  color: GlobalConfig.color_dark_gray, fontSize: 13.0))
        ],
      ),
    ));
    var tags = _buildTagsAndDate(item);
    if (tags.length > 0) {
      list.add(Row(
        textBaseline: TextBaseline.ideographic,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: tags,
      ));
    }
    return list;
  }

  List<Widget> _buildTagsAndDate(ProjectClassifyDetailBean item) {
    List<Widget> list = List();
    item.tags?.forEach((tag) {
      list.add(StrokeWidget(
          strokeWidth: 0.5,
          edgeInsets: EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
          color: GlobalConfig.color_tags,
          childWidget: Text(
            tag.name,
            style: TextStyle(
                fontSize: 11.0,
                color: GlobalConfig.color_tags,
                fontWeight: FontWeight.w100),
          )));
    });
    String chapterNameStr =
        "${StringUtil.isNullOrEmpty(item.superChapterName) ? "" : "${(list.length <= 0 ? "分类：" : "  ")}${item.superChapterName}"}"
        "${(StringUtil.isNullOrEmpty(item.superChapterName) || StringUtil.isNullOrEmpty(item.chapterName)) ? "" : "/"}"
        "${StringUtil.isNullOrEmpty(item.chapterName) ? "" : item.chapterName}";
    if (!StringUtil.isNullOrEmpty(chapterNameStr.trim())) {
      list.add(Text(
        chapterNameStr,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13.0, color: GlobalConfig.color_dark_gray),
      ));
    }
    return list;
  }
}