import 'dart:convert';

import 'package:newbug/generated/json/base/json_field.dart';
import 'package:newbug/generated/json/config_entity.g.dart';

export 'package:newbug/generated/json/config_entity.g.dart';

@JsonSerializable()
class ConfigEntity {
  ///Like页接口地址
  @JSONField(name: 'home_like_tablist')
  List<ConfigHomeLikeTablist>? homeLikeTablist;

  ///默认0正常 1审核
  int? aly;
  int? mode;

  ///举报弹窗
  @JSONField(name: 'report_list')
  List<ConfigReportList>? reportList;

  ///招呼语
  @JSONField(name: 'greeting_list')
  List<ConfigGreetingList>? greetingList;

  ///系统账号
  @JSONField(name: 'sys_account')
  ConfigSysAccount? sysAccount;

  ConfigHtml? html;

  ///聊天等级
  @JSONField(name: 'chat_lvl')
  ConfigChatLvl? chatLvl;

  ///解锁等级
  @JSONField(name: 'ppv_unlock_lvl')
  ConfigPpvUnlockLvl? ppvUnlockLvl;

  ///开关配置
  int? config;
  @JSONField(name: 'active_internal')
  int? activeInternal;
  @JSONField(name: 'account_del_list')
  List<String>? accountDelList;
  int? fold;
  @JSONField(name: 'online_api_interval')
  int? onlineApiInterval;
  @JSONField(name: 'last_active_interval')
  int? lastActiveInterval;
  @JSONField(name: 'user_online_dismiss_interval')
  int? userOnlineDismissInterval;
  @JSONField(name: 'single_model_max_stick_top_number')
  int? singleModelMaxStickTopNumber;
  @JSONField(name: 'conversation_count_per_page')
  int? conversationCountPerPage;
  @JSONField(name: 'tool_map_max_scale')
  int? toolMapMaxScale;
  @JSONField(name: 'pay_plat')
  int? payPlat;
  @JSONField(name: 'invitation_entry')
  int? invitationEntry;
  @JSONField(name: 'call_video_ttl')
  int? callVideoTtl;
  @JSONField(name: 'svc_config')
  ConfigSvcConfig? svcConfig;

  ///刷新match的间隔时间
  @JSONField(name: 'match_page_refresh_interval')
  int? matchPageRefreshInterval;

  /// 一共有两个条件，主播发送私密内容后用户再次进入私聊页面，满足一下两个条件的未解锁消息展示在提示栏中
  /// 1. PPV 消息之后发送的消息数默认 10 条，消息数后台可配置
  /// 2. PPV 发送超过 5 分钟后未解锁提醒则将该条内容展示提醒，时间后态可配置
  /// 未解锁PPV提醒延迟时间 - ppv解锁提示栏的逻辑 - 秒
  @JSONField(name: 'ppv_tooltip_show_delay_time')
  int? ppvTooltipShowDelayTime;

  /// 未解锁PPV发送后超过配置条数 - ppv解锁提示栏的逻辑 - 条数
  @JSONField(name: 'ppv_tooltip_show_min_num')
  int? ppvTooltipShowMinNum;

  /// 支付方式: 0 应用内支付  1 H5支付
  @JSONField(name: 'app_pay')
  int? appPay;

  /// 如果是0，那么不检测，否则检测
  @JSONField(name: 'jail_detect')
  int? jailDetect;

  ConfigEntity();

  factory ConfigEntity.fromJson(Map<String, dynamic> json) =>
      $ConfigEntityFromJson(json);

  Map<String, dynamic> toJson() => $ConfigEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// 服务条款
  String get terms => html?.terms ?? "";

  /// 隐私政策
  String get privacy => html?.privacy ?? "";
}

@JsonSerializable()
class ConfigHomeLikeTablist {
  String? title;
  String? url;
  @JSONField(name: 'id')
  int? tabId;
  @JSONField(name: 'default')
  int? tabDefault;

  ConfigHomeLikeTablist();

  factory ConfigHomeLikeTablist.fromJson(Map<String, dynamic> json) =>
      $ConfigHomeLikeTablistFromJson(json);

  Map<String, dynamic> toJson() => $ConfigHomeLikeTablistToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConfigReportList {
  String? title;
  int? id;

  ConfigReportList();

  factory ConfigReportList.fromJson(Map<String, dynamic> json) =>
      $ConfigReportListFromJson(json);

  Map<String, dynamic> toJson() => $ConfigReportListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConfigGreetingList {
  String? title;
  int? id;

  ConfigGreetingList();

  factory ConfigGreetingList.fromJson(Map<String, dynamic> json) =>
      $ConfigGreetingListFromJson(json);

  Map<String, dynamic> toJson() => $ConfigGreetingListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConfigSysAccount {
  ///通知账号
  @JSONField(name: 'notice_account')
  String? noticeAccount;
  @JSONField(name: 'push_account')
  String? pushAccount;

  ///客服账号
  @JSONField(name: 'service_account')
  String? serviceAccount;

  @JSONField(name: 'salary_kf_account')
  String? salaryKfAccount;
  @JSONField(name: 'quality_kf_account')
  String? qualityKfAccount;
  @JSONField(name: 'gpt_kf_account')
  String? gptKfAccount;
  @JSONField(name: 'super_kf_account')
  String? superKfAccount;

  ConfigSysAccount();

  factory ConfigSysAccount.fromJson(Map<String, dynamic> json) =>
      $ConfigSysAccountFromJson(json);

  Map<String, dynamic> toJson() => $ConfigSysAccountToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConfigHtml {
  String? terms;
  String? privacy;

  ConfigHtml();

  factory ConfigHtml.fromJson(Map<String, dynamic> json) =>
      $ConfigHtmlFromJson(json);

  Map<String, dynamic> toJson() => $ConfigHtmlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConfigChatLvl {
  int? lvl1;
  int? lvl2;
  int? lvl3;

  ConfigChatLvl();

  factory ConfigChatLvl.fromJson(Map<String, dynamic> json) =>
      $ConfigChatLvlFromJson(json);

  Map<String, dynamic> toJson() => $ConfigChatLvlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConfigPpvUnlockLvl {
  int? lvl1;
  int? lvl2;
  int? lvl3;

  ConfigPpvUnlockLvl();

  factory ConfigPpvUnlockLvl.fromJson(Map<String, dynamic> json) =>
      $ConfigPpvUnlockLvlFromJson(json);

  Map<String, dynamic> toJson() => $ConfigPpvUnlockLvlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ConfigSvcConfig {
  ConfigSvcConfig();

  factory ConfigSvcConfig.fromJson(Map<String, dynamic> json) =>
      $ConfigSvcConfigFromJson(json);

  Map<String, dynamic> toJson() => $ConfigSvcConfigToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
