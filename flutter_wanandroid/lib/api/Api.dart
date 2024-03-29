class Api {
  static final String BASE_URL = "https://www.wanandroid.com/";

  // banner
  static final String HOME_BANNER = "banner/json";
  //文章列表
  static final String HOME_LIST = "article/list/";

  static final String PROJECT_NEWEST = BASE_URL + "article/listproject/";
  static final String PROJECT_TREE =  "project/tree/json";
  static final String PROJECT_LIST = "project/list/";
  static final String SEARCH_LIST = BASE_URL + "article/query/";
  static final String TREES_LIST = BASE_URL + "tree/json";
  static final String TREES_DETAIL_LIST = BASE_URL + "article/list/";
  // 微信公众号
  static final String MP_WECHAT_NAMES = "wxarticle/chapters/json";
  // 某个公众号列表
  static final String MP_WECHAT_LIST =  "wxarticle/list/";
  static final String AVATAR = "https://api.adorable.io/avatars/200/";
  static final String AVATAR_GITHUB = "https://github.com/identicons/";
  static final String AVATAR_CODING =
      "https://coding.net/static/fruit_avatar/Fruit-";
  static final String AVATAR_LEGO = "https://randomuser.me/api/portraits/lego/";
  static final String LOGIN = BASE_URL + "user/login";
  static final String REGISTER = BASE_URL + "user/register";
  static final String COLLECTED_ARTICLE = BASE_URL + "lg/collect/list/";
  static final String COLLECT_IN_ARTICLE = BASE_URL + "lg/collect/";
  static final String COLLECT_OUT_ARTICLE = BASE_URL + "lg/collect/add/json";
  static final String UNCOLLECT_ARTICLE = BASE_URL + "lg/uncollect_originId/";

  static final String DEFAULT_PROJECT_IMG =
      "wanandroid.com/resources/image/pc/default_project_img.jpg";
}
