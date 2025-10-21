class Path {
  //static const String baseUrl = "https://chillvibeapp.com";

  static const String baseUrl = "https://api-test.chillvibeapp.com";

  ///系统配置Config
  static const String globalConfig = "/gx/cfg_blob";

  ///获取上传图片&视频地址
  static const String globalUploadUrl = "/gx/up_linkx";

  ///事件埋点上报
  static const String eventLog = "/ua/evt_logn";

  ///用户状态上报
  static const String status = "/ua/sts_meta";

  ///检查更新
  static const String updateInfo = "/gx/up_meta";

  ///用户卡片
  static const String userCard = "/mx/swp_list";

  ///卡片 Like&Pass
  static const String cardLike = "/ua/u_pickv";

  ///flash chat
  static const String flashChat = "/ua/fchat_req";

  ///上报位置、通知权限
  static const String updateSwitch = "/ua/swch_upd";

  ///小号、续订检测
  static const String alert = "/ux/alt_boxv";

  ///卡片资料详情
  static const String otherProfile = "/ua/usr_meta";
}

/*

login/google	lg/g_authx
login/email	lg/e_authn
account/editmineinfo	ua/prof_mod
account/queryusersinfo	ua/usr_qryx
account/mineprofile	ua/self_meta
account/notifyupdate	ua/ntf_syncx
account/sayHi	ua/hi_sendx
global/taglist	gx/tag_pool
account/delete	ua/del_actx
pay/shoplist	px/shop_idx
pay/webshopaction	px/shop_wact
privacy/medialist	rx/md_lstq
privacy/mediadel	rx/md_dely
privacy/mediaadd	rx/md_addn
privacy/look	rx/look_mod
pay/genorder	px/ord_gnx
pay/checkorder	px/ord_ckv
privacy/addrequest	rx/req_addm
pay/trace	px/ord_trcx
account/queryvisitorlist	ua/vst_listx
global/firstentry	gx/fst_entn
account/block	ua/u_blkxx
account/readlike	ua/rlk_getx
account/tokenrefresh	ua/tkn_rfsh
account/pushtoken	ua/ptk_bind
account/userreport	ua/rpt_usxx
account/querlistynum	ua/qcnt_lnx
match/read	mx/mch_read
app/chat/recall	cx/msg_rclx
global/pushtrace	gx/push_tcx
account/v2/online_ulist	ua/onl_lst2
account/online_info	ua/onl_meta
v2/account/querylikelist	ua/qlk_lstx
account/hide	ua/hide_mod*/
