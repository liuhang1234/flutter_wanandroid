# flutter_wanandroid

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 1json使用 link https://blog.csdn.net/qq_31350875/article/details/90498384
  1.新建类和属性（字段）以及带参构造方法，注意属性类型
  2.引入json_annotation，即插入import 'package:json_annotation/json_annotation.dart';
  3.指定此类的生成代码，part '类名.g.dart';需要放入到实体类中
  4.添加序列化标注，@JsonSerializable()，注意括号
  5.添加反序列化和序列化方法fromJson和toJson，即
  factory 类名.fromJson(Map<String, dynamic> json) =>_$类名FromJson(json);
  和
  Map<String, dynamic> toJson() => _$类名ToJson(this);

  在生成对应的.g.dart文件
  忽略报错，使用命令flutter packages pub run build_runner build
  进行一次性构建，构建过程中flutter会使用Model类的源文件（包含@JsonSerializable标注的）来生成对应的.g.dart文件。
  另外，也可以使用命令flutter packages pub run build_runner watch，
  这个命令可以实现文件监听，自动地为你后续创建的实体类生成对应的.g.dart文件

  使用 --使用`json.encode`和`json.decode`，需要引入`import 'dart:convert';`。

   //序列化为json字符串，变量modelObject是实体类对象
   String jsonStr = json.encode(modelObject);
   //反序列化为实体类，变量jsonString是与实体类完全匹配的json字符串，BaiduWebPosition是实体类名
   var modelObj= BaiduWebPosition.fromJson(json.decode(jsonString));

   以banner为例
   Banner
   @JsonSerializable()
   class Banner {
     String desc;
     int id;
     String imagePath;
     int isVisible;
     int order;
     String title;
     int type;
     String url;

     Banner(this.desc, this.id, this.imagePath, this.isVisible, this.order,
         this.title, this.type, this.url);

     factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

     Map<String, dynamic> toJson() => _$BannerToJson(this);
   }

    在终端terminal 输入 flutter packages pub run build_runner build || flutter packages pub run build_runner watch
    即会帮你生成Banner.g.dart文件

    生成的内容为
    Banner _$BannerFromJson(Map<String, dynamic> json) {
      return Banner(
        json['desc'] as String,
        json['id'] as int,
        json['imagePath'] as String,
        json['isVisible'] as int,
        json['order'] as int,
        json['title'] as String,
        json['type'] as int,
        json['url'] as String,
      );
    }

    Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
          'desc': instance.desc,
          'id': instance.id,
          'imagePath': instance.imagePath,
          'isVisible': instance.isVisible,
          'order': instance.order,
          'title': instance.title,
          'type': instance.type,
          'url': instance.url,
        };
        
    flutter packages pub run build_runner clean || 
    flutter packages pub run build_runner build --delete-conflicting-outputs 生成json.g.dart有问题时
    
##  2 类似viewpager + fragment + bottomnavigation联动 底部导航
    保留view 不被销毁 以 _ArticleListPage为例
    1) _ArticleListPage with AutomaticKeepAliveClientMixin 
    2)  重写
          @override
          // TODO: implement wantKeepAlive
          bool get wantKeepAlive => true;
          改为true即可 这样 该页面 即可不会被销毁
        
## 3 AppBar占用顶部状态栏
    使用SafeArea包裹着该view,就不会占用状态栏了，使用在ProjectPage.dart
    SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white70,
              appBar: tabBar,
              body: tabBarBodyView,
            )
          );
    详细使用见 
    Flutter SafeArea - 异形屏适配利器
    https://cloud.tencent.com/developer/article/1472092

