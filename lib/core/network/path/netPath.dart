class ApiPathRelease {
  //static const String baseUrl = "https://chillvibeapp.com";

  ///测试环境
  static const String baseUrlDebug = "https://api-test.chillvibeapp.com";

  ///系统配置Config
  static const String globalConfig = "/gx/cfg_blob";

  ///Email-登录
  static const String emailLogin = "/lg/e_authn";

  ///获取上传图片&视频地址
  static const String globalUploadUrl = "/gx/up_linkx";

  ///事件埋点上报
  static const String eventLog = "/ua/evt_logn";

  ///用户状态上报
  static const String updateUserStatus = "/ua/sts_meta";

  ///检查更新
  static const String updateInfo = "/gx/up_meta";

  ///用户卡片
  static const String homeSwiperCards = "/mx/swp_list";

  ///卡片 Like&Pass
  static const String cardChoose = "/ua/u_pickv";

  ///flash chat
  static const String flashChat = "/ua/fchat_req";

  ///上报位置、通知权限
  static const String updateSwitch = "/ua/swch_upd";

  ///小号、续订检测
  static const String alert = "/ux/alt_boxv";

  ///卡片资料详情
  static const String otherProfile = "/ua/usr_meta";

  ///举报用户
  static const String reportUser = "/ua/rpt_usxx";

  ///拉黑用户
  static const String blockUser = "/ua/u_blkxx";

  ///用户更新位置(/account/location/update)
  static const String updateLocation = "";

  ///Google-登录
  static const String googleLogin = "/lg/g_authx";

  ///刷新Token
  static const String refreshToken = "/ua/tkn_rfsh";

  ///注册填写用户信息
  static const String editUserInfo = "/ua/prof_mod";

  ///退出登录
  static const String exitLogin = "/ua/ptk_bind";

  ///注销账号
  static const String deleteAccount = "/ua/del_actx";

  ///who likes you 列表 (入参tag)
  static const String getWLMList = "/ua/vst_listx";

  ///Visitor访客列表 （入参last_id）
  static const String visitorList = "/ua/vst_listx";

  ///You Liked
  static const String likeList = "/ua/qlk_lstx";

  ///WLM已读
  static const String readLike = "/ua/rlk_getx";

  ///发送招呼
  static const String sayHi = "/ua/hi_sendx";

  ///批量获取用户信息
  static const String getUsersInfoList = "/ua/usr_qryx";

  ///查询在线用户列表
  static const String getOnlineUserList = "/ua/onl_lst2";

  ///查询指定用户id列表中 在线用户
  static const String queryOnlineUser = "/ua/onl_meta";

  ///查询WLM、Visitor数量
  static const String queryWlmOrVisitorCount = "/ua/qcnt_lnx";

  ///NewMatch 标记已读
  static const String matchRead = "/mx/mch_read";

  ///获取客服默认消息
  static const String getServiceMessage = "/gx/fst_entn";

  ///解锁私密内容
  static const String unlockPrivate = "/rx/look_mod";

  ///检查是否有私密相册权限
  static const String checkPrivatePermission = "/rx/req_addm";

  ///消息撤回
  static const String recallMessage = "/cx/msg_rclx";

  ///用户信息
  static const String getUserInfo = "/ua/self_meta";

  ///私密相册列表
  static const String privateAlbumList = "/rx/md_lstq";

  ///设置隐私状态
  static const String setPrivateStatus = "/ua/hide_mod";

  ///兴趣Tag列表
  static const String getTagList = "/gx/tag_pool";

  ///私密图片上传成功添加
  static const String addPrivateImage = "/rx/md_addn";

  ///删除私密照片&视频
  static const String deletePrivateMedia = "/rx/md_dely";

  ///通知开关设置
  static const String notifyUpdate = "/ua/ntf_syncx";

  ///商品列表
  static const String productList = "/px/shop_idx";

  ///获取订单
  static const String getOrder = "/px/ord_gnx";

  ///订单回调
  static const String orderCallback = "/px/ord_wact";

  ///支付打点
  static const String payTrace = "/px/ord_trcx";

  ///web shop action
  static const String webShopAction = "/px/shop_wact";

  ///离线推送的点击回传
  static const String pushTrace = "/gx/push_tcx";

  ///修改离线新的push token
  static const String updatePushToken = "";

  ///用户行为上报
  static const String updateUserAction = "/ua/adjust_info";
}

/*class ApiPath2 {
  static const String baseUrl = "https://api-test.localoveapp.com";

  ///系统配置Config
  static const String globalConfig = "/global/config";

  ///Email-登录
  static const String emailLogin = "/login/email";

  ///google-登录
  static const String googleLogin = "/login/google";

  ///刷新Token
  static const String refreshToken = "/account/tokenrefresh";

  ///注册填写用户信息
  static const String editUserInfo = "/account/editmineinfo";

  ///退出登录
  static const String exitLogin = "/account/status";

  ///注销账号
  static const String deleteAccount = "/account/delete";

  ///用户状态上报
  static const String updateUserStatus = "/account/status";

  ///检查更新
  //static const String updateInfo = "/global/updateinfo";

  ///用户卡片
  static const String homeSwiperCards = "/v2/swipe/userlist";

  ///卡片 Like&Pass
  static const String cardChoose = "/account/userchoose";

  ///flash chat
  static const String flashChat = "/account/flashchat";

  ///上报位置、通知权限(登录后 首页 上报位置、通知权限是否开启,此接口是 ”通知“ 和 ”位置“权限共用)
  static const String updateSwitch = "/account/updateswitch";

  ///小号、续订检测
  static const String alert = "/user/alert";

  ///他人资料详情
  static const String cardDetails = "/account/otherprofile";

  ///举报用户(对用户进行举报)
  static const String reportUser = "/account/userreport";

  ///拉黑用户
  static const String blockUser = "/account/block";

  ///用户更新位置(没有映射)
  static const String updateLocation = "/account/location/update";

  ///获取WLM列表
  static const String getWLMList = "/v2/account/querylikelist";

  ///获取likes列表
  static const String likeList = "/v2/account/querylikelist";

  ///WLM已读
  static const String readLike = "/account/readlike";

  ///发送招呼
  static const String sayHi = "/account/sayHi";

  ///批量获取用户信息
  static const String getProfileList = "/account/queryusersinfo";

  ///查询在线用户列表
  static const String getOnlineList = "/account/v2/online_ulist";

  ///查询指定用户id列表中 在线用户
  static const String queryOnlineUser = "/account/online_info";

  ///查询WLM、Visitor新增数量和总数量
  static const String queryWlmOrVisitorCount = "/account/querlistynum";

  ///NewMatch 标记已读
  static const String matchRead = "/match/read";

  ///获取客服默认消息
  static const String getServiceMessage = "/global/firstentry";

  ///解锁私密内容 （解锁私密内容 包含单张、打包）
  static const String unlockPrivate = "/privacy/look";

  ///todo 检查是否有私密相册权限
  static const String checkPrivatePermission = "/rx/req_addm";

  ///消息撤回
  static const String recallMessage = "/app/chat/recall";

  ///获取上传图片&视频地址
  static const String globalUploadUrl = "/global/uploadurl";

  ///用户信息
  static const String getUserInfo = "/account/mineprofile";

  ///私密相册列表
  static const String privateAlbumList = "/privacy/medialist";

  ///设置隐私状态
  // static const String setPrivateStatus = "/account/hide";

  ///Visitor访客列表
  static const String visitorList = "/account/queryvisitorlist";

  ///兴趣Tag列表
  static const String getTagList = "/global/taglist";

  ///私密图片上传成功添加
  static const String addPrivateImage = "/privacy/mediaadd";

  ///删除私密照片&视频
  static const String deletePrivateMedia = "/privacy/mediadel";

  ///通知开关设置
  static const String notifyUpdate = "/account/notifyupdate";

  ///拉黑列表
  static const String blackList = "/user/blackList";

  ///解除拉黑
  static const String unblack = "/user/unblock";

  ///商品列表
  static const String productList = "/pay/shoplist";

  ///获取订单
  static const String createOrder = "/pay/genorder";

  ///订单回调
  static const String checkOrder = "/pay/checkorder";

  ///支付打点
  static const String payTrace = "/pay/trace";

  ///修改离线新的push token
  static const String updatePushToken = "/edit/pushtoken";

  ///离线推送的点击回传
  // static const String pushTrace = "/global/pushtrace";

  ///用户行为上报
  static const String updateUserAction = "/ua/adjust_info";

  //////////////////////////////////////////

  static const String RESTORE = "by/v7w8x"; //恢复订单

  ///事件埋点上报
  static const String eventLog = "/ua/evt_logn";

  ///web shop action
  static const String webShopAction = "/px/shop_wact";
}*/

class ApiPath {
  static const String baseUrl = "https://api-test.9pmapp.com";

  ///系统配置Config
  static const String globalConfig = "/setting/a3b4c";

  ///Email-登录
  static const String emailLogin = "/login/h5i6j";

  ///google-登录
  static const String googleLogin = "/login/g0g1e";

  ///注销账号
  static const String deleteAccount = "/account/delx1";

  ///刷新Token
  static const String refreshToken = "/act/a1b2c";

  ///获取上传图片&视频地址
  static const String globalUploadUrl = "/global/up1d1";

  ///批量获取用户信息
  static const String getProfileList = "/usr/s3t4u";

  ///用户信息
  static const String getUserInfo = "/act/m9n0o";

  ///发送招呼
  static const String sayHi = "/act/h3i4j";

  ///删除私密照片&视频
  static const String deletePrivateMedia = "/pr/i1j2k";

  ///兴趣Tag列表
  static const String getTagList = "/global/tg1st";

  ///私密图片上传成功添加
  static const String addPrivateImage = "/pr/l3m4n";

  ///私密相册列表
  static const String privateAlbumList = "/pr/f9g0h";

  ///解锁私密内容 （解锁私密内容 包含单张、打包）
  static const String unlockPrivate = "/pr/o5p6q";

  ///查询在线用户列表
  static const String getOnlineList = "/usr/x1y2z";

  ///拉黑列表
  static const String blackList = "/usr/k7l8m";

  ///获取likes列表
  static const String likeList = "/act/q9r0s";

  ///退出登录
  static const String exitLogin = "/account/sttus";

  ///用户状态上报
  static const String updateUserStatus = "/account/sttus";

  ///Visitor访客列表
  static const String visitorList = "/act/n7o8p";

  ///flash chat
  static const String flashChat = "/act/e1f2g";

  ///拉黑用户
  static const String blockUser = "/account/bl0k1";

  ///解除拉黑
  static const String unblack = "/usr/n9o0p";

  ///h5 pay
  static const String webShopAction = "/by/j9k0l";

  ///adjust info
  static const String updateUserAction = "/monitor/useraction";

  ///用户卡片
  static const String homeSwiperCards = "/main/y7z8a";

  ///卡片 Like&Pass
  static const String cardChoose = "/act/b9c0d";

  ///小号、续订检测
  static const String alert = "/act/b1c2d";

  ///注册填写用户信息
  static const String editUserInfo = "/act/d3e4f";

  ///上报位置、通知权限(登录后 首页 上报位置、通知权限是否开启,此接口是 ”通知“ 和 ”位置“权限共用)
  static const String updateSwitch = "/act/j7k8l";

  ///举报用户(对用户进行举报)
  static const String reportUser = "/account/usrpt";

  ///商品列表
  static const String productList = "/by/m1n2o";

  ///创建订单
  static const String createOrder = "/by/p3q4r";

  ///支付打点
  static const String payTrace = "/by/y9z0a";

  ///订单回调
  static const String checkOrder = "/by/s5t6u";

  ///查询指定用户id列表中 在线用户
  static const String queryOnlineUser = "/account/oln91";

  ///事件埋点上报
  static const String eventLog = "/act/g5h6i";

  ///通知开关设置
  static const String notifyUpdate = "/act/w3x4y";

  ///WLM已读
  static const String readLike = "/act/t1u2v";

  ///消息撤回
  static const String recallMessage = "/im/u9v0w";

  ///获取客服默认消息
  static const String getServiceMessage = "/setting/g7h8i";

  ///NewMatch 标记已读
  static const String matchRead = "/mh/r7s8t";

  ///他人资料详情
  static const String cardDetails = "/act/v5w6x";

  ///查询WLM、Visitor新增数量和总数量
  static const String queryWlmOrVisitorCount = "/act/k5l6m";

  ///修改离线新的push token
  static const String updatePushToken = "/rp/z5a6b";

  ///////

  ///检查更新
  //static const String updateInfo = "/global/updateinfo";

  ///用户更新位置(没有映射)
  static const String updateLocation = "/account/location/update";

  ///获取WLM列表
  static const String getWLMList = "/v2/account/querylikelist";

  ///todo 检查是否有私密相册权限
  static const String checkPrivatePermission = "/rx/req_addm";

  ///设置隐私状态
  // static const String setPrivateStatus = "/account/hide";

  ///离线推送的点击回传 todo
  static const String pushTrace = "/rp/d5e6f";

  ///恢复订单 todo
  static const String restore = "by/v7w8x";

  ///用户更新位置
  //static const String updateswitch = "/account/updateswitch";
}
