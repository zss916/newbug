import 'package:newbug/core/network/model/config_entity.dart';
import 'package:newbug/generated/json/base/json_convert_content.dart';

ConfigEntity $ConfigEntityFromJson(Map<String, dynamic> json) {
  final ConfigEntity configEntity = ConfigEntity();
  final List<ConfigHomeLikeTablist>? homeLikeTablist =
      (json['home_like_tablist'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<ConfigHomeLikeTablist>(e)
                    as ConfigHomeLikeTablist,
          )
          .toList();
  if (homeLikeTablist != null) {
    configEntity.homeLikeTablist = homeLikeTablist;
  }
  final int? aly = jsonConvert.convert<int>(json['aly']);
  if (aly != null) {
    configEntity.aly = aly;
  }
  final int? mode = jsonConvert.convert<int>(json['mode']);
  if (mode != null) {
    configEntity.mode = mode;
  }
  final List<ConfigReportList>? reportList =
      (json['report_list'] as List<dynamic>?)
          ?.map(
            (e) => jsonConvert.convert<ConfigReportList>(e) as ConfigReportList,
          )
          .toList();
  if (reportList != null) {
    configEntity.reportList = reportList;
  }
  final List<ConfigGreetingList>? greetingList =
      (json['greeting_list'] as List<dynamic>?)
          ?.map(
            (e) =>
                jsonConvert.convert<ConfigGreetingList>(e)
                    as ConfigGreetingList,
          )
          .toList();
  if (greetingList != null) {
    configEntity.greetingList = greetingList;
  }
  final ConfigSysAccount? sysAccount = jsonConvert.convert<ConfigSysAccount>(
    json['sys_account'],
  );
  if (sysAccount != null) {
    configEntity.sysAccount = sysAccount;
  }
  final ConfigHtml? html = jsonConvert.convert<ConfigHtml>(json['html']);
  if (html != null) {
    configEntity.html = html;
  }
  final ConfigChatLvl? chatLvl = jsonConvert.convert<ConfigChatLvl>(
    json['chat_lvl'],
  );
  if (chatLvl != null) {
    configEntity.chatLvl = chatLvl;
  }
  final ConfigPpvUnlockLvl? ppvUnlockLvl = jsonConvert
      .convert<ConfigPpvUnlockLvl>(json['ppv_unlock_lvl']);
  if (ppvUnlockLvl != null) {
    configEntity.ppvUnlockLvl = ppvUnlockLvl;
  }
  final int? config = jsonConvert.convert<int>(json['config']);
  if (config != null) {
    configEntity.config = config;
  }
  final int? activeInternal = jsonConvert.convert<int>(json['active_internal']);
  if (activeInternal != null) {
    configEntity.activeInternal = activeInternal;
  }
  final List<String>? accountDelList =
      (json['account_del_list'] as List<dynamic>?)
          ?.map((e) => jsonConvert.convert<String>(e) as String)
          .toList();
  if (accountDelList != null) {
    configEntity.accountDelList = accountDelList;
  }
  final int? fold = jsonConvert.convert<int>(json['fold']);
  if (fold != null) {
    configEntity.fold = fold;
  }
  final int? onlineApiInterval = jsonConvert.convert<int>(
    json['online_api_interval'],
  );
  if (onlineApiInterval != null) {
    configEntity.onlineApiInterval = onlineApiInterval;
  }
  final int? lastActiveInterval = jsonConvert.convert<int>(
    json['last_active_interval'],
  );
  if (lastActiveInterval != null) {
    configEntity.lastActiveInterval = lastActiveInterval;
  }
  final int? userOnlineDismissInterval = jsonConvert.convert<int>(
    json['user_online_dismiss_interval'],
  );
  if (userOnlineDismissInterval != null) {
    configEntity.userOnlineDismissInterval = userOnlineDismissInterval;
  }
  final int? singleModelMaxStickTopNumber = jsonConvert.convert<int>(
    json['single_model_max_stick_top_number'],
  );
  if (singleModelMaxStickTopNumber != null) {
    configEntity.singleModelMaxStickTopNumber = singleModelMaxStickTopNumber;
  }
  final int? conversationCountPerPage = jsonConvert.convert<int>(
    json['conversation_count_per_page'],
  );
  if (conversationCountPerPage != null) {
    configEntity.conversationCountPerPage = conversationCountPerPage;
  }
  final int? toolMapMaxScale = jsonConvert.convert<int>(
    json['tool_map_max_scale'],
  );
  if (toolMapMaxScale != null) {
    configEntity.toolMapMaxScale = toolMapMaxScale;
  }
  final int? payPlat = jsonConvert.convert<int>(json['pay_plat']);
  if (payPlat != null) {
    configEntity.payPlat = payPlat;
  }
  final int? invitationEntry = jsonConvert.convert<int>(
    json['invitation_entry'],
  );
  if (invitationEntry != null) {
    configEntity.invitationEntry = invitationEntry;
  }
  final int? callVideoTtl = jsonConvert.convert<int>(json['call_video_ttl']);
  if (callVideoTtl != null) {
    configEntity.callVideoTtl = callVideoTtl;
  }
  final ConfigSvcConfig? svcConfig = jsonConvert.convert<ConfigSvcConfig>(
    json['svc_config'],
  );
  if (svcConfig != null) {
    configEntity.svcConfig = svcConfig;
  }
  final int? matchPageRefreshInterval = jsonConvert.convert<int>(
    json['match_page_refresh_interval'],
  );
  if (matchPageRefreshInterval != null) {
    configEntity.matchPageRefreshInterval = matchPageRefreshInterval;
  }
  final int? ppvTooltipShowDelayTime = jsonConvert.convert<int>(
    json['ppv_tooltip_show_delay_time'],
  );
  if (ppvTooltipShowDelayTime != null) {
    configEntity.ppvTooltipShowDelayTime = ppvTooltipShowDelayTime;
  }
  final int? ppvTooltipShowMinNum = jsonConvert.convert<int>(
    json['ppv_tooltip_show_min_num'],
  );
  if (ppvTooltipShowMinNum != null) {
    configEntity.ppvTooltipShowMinNum = ppvTooltipShowMinNum;
  }
  final int? appPay = jsonConvert.convert<int>(json['app_pay']);
  if (appPay != null) {
    configEntity.appPay = appPay;
  }
  final int? jailDetect = jsonConvert.convert<int>(json['jail_detect']);
  if (jailDetect != null) {
    configEntity.jailDetect = jailDetect;
  }
  return configEntity;
}

Map<String, dynamic> $ConfigEntityToJson(ConfigEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['home_like_tablist'] = entity.homeLikeTablist
      ?.map((v) => v.toJson())
      .toList();
  data['aly'] = entity.aly;
  data['mode'] = entity.mode;
  data['report_list'] = entity.reportList?.map((v) => v.toJson()).toList();
  data['greeting_list'] = entity.greetingList?.map((v) => v.toJson()).toList();
  data['sys_account'] = entity.sysAccount?.toJson();
  data['html'] = entity.html?.toJson();
  data['chat_lvl'] = entity.chatLvl?.toJson();
  data['ppv_unlock_lvl'] = entity.ppvUnlockLvl?.toJson();
  data['config'] = entity.config;
  data['active_internal'] = entity.activeInternal;
  data['account_del_list'] = entity.accountDelList;
  data['fold'] = entity.fold;
  data['online_api_interval'] = entity.onlineApiInterval;
  data['last_active_interval'] = entity.lastActiveInterval;
  data['user_online_dismiss_interval'] = entity.userOnlineDismissInterval;
  data['single_model_max_stick_top_number'] =
      entity.singleModelMaxStickTopNumber;
  data['conversation_count_per_page'] = entity.conversationCountPerPage;
  data['tool_map_max_scale'] = entity.toolMapMaxScale;
  data['pay_plat'] = entity.payPlat;
  data['invitation_entry'] = entity.invitationEntry;
  data['call_video_ttl'] = entity.callVideoTtl;
  data['svc_config'] = entity.svcConfig?.toJson();
  data['match_page_refresh_interval'] = entity.matchPageRefreshInterval;
  data['ppv_tooltip_show_delay_time'] = entity.ppvTooltipShowDelayTime;
  data['ppv_tooltip_show_min_num'] = entity.ppvTooltipShowMinNum;
  data['app_pay'] = entity.appPay;
  data['jail_detect'] = entity.jailDetect;
  return data;
}

extension ConfigEntityExtension on ConfigEntity {
  ConfigEntity copyWith({
    List<ConfigHomeLikeTablist>? homeLikeTablist,
    int? aly,
    int? mode,
    List<ConfigReportList>? reportList,
    List<ConfigGreetingList>? greetingList,
    ConfigSysAccount? sysAccount,
    ConfigHtml? html,
    ConfigChatLvl? chatLvl,
    ConfigPpvUnlockLvl? ppvUnlockLvl,
    int? config,
    int? activeInternal,
    List<String>? accountDelList,
    int? fold,
    int? onlineApiInterval,
    int? lastActiveInterval,
    int? userOnlineDismissInterval,
    int? singleModelMaxStickTopNumber,
    int? conversationCountPerPage,
    int? toolMapMaxScale,
    int? payPlat,
    int? invitationEntry,
    int? callVideoTtl,
    ConfigSvcConfig? svcConfig,
    int? matchPageRefreshInterval,
    int? ppvTooltipShowDelayTime,
    int? ppvTooltipShowMinNum,
    int? appPay,
    int? jailDetect,
  }) {
    return ConfigEntity()
      ..homeLikeTablist = homeLikeTablist ?? this.homeLikeTablist
      ..aly = aly ?? this.aly
      ..mode = mode ?? this.mode
      ..reportList = reportList ?? this.reportList
      ..greetingList = greetingList ?? this.greetingList
      ..sysAccount = sysAccount ?? this.sysAccount
      ..html = html ?? this.html
      ..chatLvl = chatLvl ?? this.chatLvl
      ..ppvUnlockLvl = ppvUnlockLvl ?? this.ppvUnlockLvl
      ..config = config ?? this.config
      ..activeInternal = activeInternal ?? this.activeInternal
      ..accountDelList = accountDelList ?? this.accountDelList
      ..fold = fold ?? this.fold
      ..onlineApiInterval = onlineApiInterval ?? this.onlineApiInterval
      ..lastActiveInterval = lastActiveInterval ?? this.lastActiveInterval
      ..userOnlineDismissInterval =
          userOnlineDismissInterval ?? this.userOnlineDismissInterval
      ..singleModelMaxStickTopNumber =
          singleModelMaxStickTopNumber ?? this.singleModelMaxStickTopNumber
      ..conversationCountPerPage =
          conversationCountPerPage ?? this.conversationCountPerPage
      ..toolMapMaxScale = toolMapMaxScale ?? this.toolMapMaxScale
      ..payPlat = payPlat ?? this.payPlat
      ..invitationEntry = invitationEntry ?? this.invitationEntry
      ..callVideoTtl = callVideoTtl ?? this.callVideoTtl
      ..svcConfig = svcConfig ?? this.svcConfig
      ..matchPageRefreshInterval =
          matchPageRefreshInterval ?? this.matchPageRefreshInterval
      ..ppvTooltipShowDelayTime =
          ppvTooltipShowDelayTime ?? this.ppvTooltipShowDelayTime
      ..ppvTooltipShowMinNum = ppvTooltipShowMinNum ?? this.ppvTooltipShowMinNum
      ..appPay = appPay ?? this.appPay
      ..jailDetect = jailDetect ?? this.jailDetect;
  }
}

ConfigHomeLikeTablist $ConfigHomeLikeTablistFromJson(
  Map<String, dynamic> json,
) {
  final ConfigHomeLikeTablist configHomeLikeTablist = ConfigHomeLikeTablist();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    configHomeLikeTablist.title = title;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    configHomeLikeTablist.url = url;
  }
  final int? tabId = jsonConvert.convert<int>(json['id']);
  if (tabId != null) {
    configHomeLikeTablist.tabId = tabId;
  }
  final int? tabDefault = jsonConvert.convert<int>(json['default']);
  if (tabDefault != null) {
    configHomeLikeTablist.tabDefault = tabDefault;
  }
  return configHomeLikeTablist;
}

Map<String, dynamic> $ConfigHomeLikeTablistToJson(
  ConfigHomeLikeTablist entity,
) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['url'] = entity.url;
  data['id'] = entity.tabId;
  data['default'] = entity.tabDefault;
  return data;
}

extension ConfigHomeLikeTablistExtension on ConfigHomeLikeTablist {
  ConfigHomeLikeTablist copyWith({
    String? title,
    String? url,
    int? tabId,
    int? tabDefault,
  }) {
    return ConfigHomeLikeTablist()
      ..title = title ?? this.title
      ..url = url ?? this.url
      ..tabId = tabId ?? this.tabId
      ..tabDefault = tabDefault ?? this.tabDefault;
  }
}

ConfigReportList $ConfigReportListFromJson(Map<String, dynamic> json) {
  final ConfigReportList configReportList = ConfigReportList();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    configReportList.title = title;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    configReportList.id = id;
  }
  return configReportList;
}

Map<String, dynamic> $ConfigReportListToJson(ConfigReportList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['id'] = entity.id;
  return data;
}

extension ConfigReportListExtension on ConfigReportList {
  ConfigReportList copyWith({String? title, int? id}) {
    return ConfigReportList()
      ..title = title ?? this.title
      ..id = id ?? this.id;
  }
}

ConfigGreetingList $ConfigGreetingListFromJson(Map<String, dynamic> json) {
  final ConfigGreetingList configGreetingList = ConfigGreetingList();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    configGreetingList.title = title;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    configGreetingList.id = id;
  }
  return configGreetingList;
}

Map<String, dynamic> $ConfigGreetingListToJson(ConfigGreetingList entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['id'] = entity.id;
  return data;
}

extension ConfigGreetingListExtension on ConfigGreetingList {
  ConfigGreetingList copyWith({String? title, int? id}) {
    return ConfigGreetingList()
      ..title = title ?? this.title
      ..id = id ?? this.id;
  }
}

ConfigSysAccount $ConfigSysAccountFromJson(Map<String, dynamic> json) {
  final ConfigSysAccount configSysAccount = ConfigSysAccount();
  final String? noticeAccount = jsonConvert.convert<String>(
    json['notice_account'],
  );
  if (noticeAccount != null) {
    configSysAccount.noticeAccount = noticeAccount;
  }
  final String? pushAccount = jsonConvert.convert<String>(json['push_account']);
  if (pushAccount != null) {
    configSysAccount.pushAccount = pushAccount;
  }
  final String? serviceAccount = jsonConvert.convert<String>(
    json['service_account'],
  );
  if (serviceAccount != null) {
    configSysAccount.serviceAccount = serviceAccount;
  }
  final String? salaryKfAccount = jsonConvert.convert<String>(
    json['salary_kf_account'],
  );
  if (salaryKfAccount != null) {
    configSysAccount.salaryKfAccount = salaryKfAccount;
  }
  final String? qualityKfAccount = jsonConvert.convert<String>(
    json['quality_kf_account'],
  );
  if (qualityKfAccount != null) {
    configSysAccount.qualityKfAccount = qualityKfAccount;
  }
  final String? gptKfAccount = jsonConvert.convert<String>(
    json['gpt_kf_account'],
  );
  if (gptKfAccount != null) {
    configSysAccount.gptKfAccount = gptKfAccount;
  }
  final String? superKfAccount = jsonConvert.convert<String>(
    json['super_kf_account'],
  );
  if (superKfAccount != null) {
    configSysAccount.superKfAccount = superKfAccount;
  }
  return configSysAccount;
}

Map<String, dynamic> $ConfigSysAccountToJson(ConfigSysAccount entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['notice_account'] = entity.noticeAccount;
  data['push_account'] = entity.pushAccount;
  data['service_account'] = entity.serviceAccount;
  data['salary_kf_account'] = entity.salaryKfAccount;
  data['quality_kf_account'] = entity.qualityKfAccount;
  data['gpt_kf_account'] = entity.gptKfAccount;
  data['super_kf_account'] = entity.superKfAccount;
  return data;
}

extension ConfigSysAccountExtension on ConfigSysAccount {
  ConfigSysAccount copyWith({
    String? noticeAccount,
    String? pushAccount,
    String? serviceAccount,
    String? salaryKfAccount,
    String? qualityKfAccount,
    String? gptKfAccount,
    String? superKfAccount,
  }) {
    return ConfigSysAccount()
      ..noticeAccount = noticeAccount ?? this.noticeAccount
      ..pushAccount = pushAccount ?? this.pushAccount
      ..serviceAccount = serviceAccount ?? this.serviceAccount
      ..salaryKfAccount = salaryKfAccount ?? this.salaryKfAccount
      ..qualityKfAccount = qualityKfAccount ?? this.qualityKfAccount
      ..gptKfAccount = gptKfAccount ?? this.gptKfAccount
      ..superKfAccount = superKfAccount ?? this.superKfAccount;
  }
}

ConfigHtml $ConfigHtmlFromJson(Map<String, dynamic> json) {
  final ConfigHtml configHtml = ConfigHtml();
  final String? terms = jsonConvert.convert<String>(json['terms']);
  if (terms != null) {
    configHtml.terms = terms;
  }
  final String? privacy = jsonConvert.convert<String>(json['privacy']);
  if (privacy != null) {
    configHtml.privacy = privacy;
  }
  return configHtml;
}

Map<String, dynamic> $ConfigHtmlToJson(ConfigHtml entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['terms'] = entity.terms;
  data['privacy'] = entity.privacy;
  return data;
}

extension ConfigHtmlExtension on ConfigHtml {
  ConfigHtml copyWith({String? terms, String? privacy}) {
    return ConfigHtml()
      ..terms = terms ?? this.terms
      ..privacy = privacy ?? this.privacy;
  }
}

ConfigChatLvl $ConfigChatLvlFromJson(Map<String, dynamic> json) {
  final ConfigChatLvl configChatLvl = ConfigChatLvl();
  final int? lvl1 = jsonConvert.convert<int>(json['lvl1']);
  if (lvl1 != null) {
    configChatLvl.lvl1 = lvl1;
  }
  final int? lvl2 = jsonConvert.convert<int>(json['lvl2']);
  if (lvl2 != null) {
    configChatLvl.lvl2 = lvl2;
  }
  final int? lvl3 = jsonConvert.convert<int>(json['lvl3']);
  if (lvl3 != null) {
    configChatLvl.lvl3 = lvl3;
  }
  return configChatLvl;
}

Map<String, dynamic> $ConfigChatLvlToJson(ConfigChatLvl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['lvl1'] = entity.lvl1;
  data['lvl2'] = entity.lvl2;
  data['lvl3'] = entity.lvl3;
  return data;
}

extension ConfigChatLvlExtension on ConfigChatLvl {
  ConfigChatLvl copyWith({int? lvl1, int? lvl2, int? lvl3}) {
    return ConfigChatLvl()
      ..lvl1 = lvl1 ?? this.lvl1
      ..lvl2 = lvl2 ?? this.lvl2
      ..lvl3 = lvl3 ?? this.lvl3;
  }
}

ConfigPpvUnlockLvl $ConfigPpvUnlockLvlFromJson(Map<String, dynamic> json) {
  final ConfigPpvUnlockLvl configPpvUnlockLvl = ConfigPpvUnlockLvl();
  final int? lvl1 = jsonConvert.convert<int>(json['lvl1']);
  if (lvl1 != null) {
    configPpvUnlockLvl.lvl1 = lvl1;
  }
  final int? lvl2 = jsonConvert.convert<int>(json['lvl2']);
  if (lvl2 != null) {
    configPpvUnlockLvl.lvl2 = lvl2;
  }
  final int? lvl3 = jsonConvert.convert<int>(json['lvl3']);
  if (lvl3 != null) {
    configPpvUnlockLvl.lvl3 = lvl3;
  }
  return configPpvUnlockLvl;
}

Map<String, dynamic> $ConfigPpvUnlockLvlToJson(ConfigPpvUnlockLvl entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['lvl1'] = entity.lvl1;
  data['lvl2'] = entity.lvl2;
  data['lvl3'] = entity.lvl3;
  return data;
}

extension ConfigPpvUnlockLvlExtension on ConfigPpvUnlockLvl {
  ConfigPpvUnlockLvl copyWith({int? lvl1, int? lvl2, int? lvl3}) {
    return ConfigPpvUnlockLvl()
      ..lvl1 = lvl1 ?? this.lvl1
      ..lvl2 = lvl2 ?? this.lvl2
      ..lvl3 = lvl3 ?? this.lvl3;
  }
}

ConfigSvcConfig $ConfigSvcConfigFromJson(Map<String, dynamic> json) {
  final ConfigSvcConfig configSvcConfig = ConfigSvcConfig();
  return configSvcConfig;
}

Map<String, dynamic> $ConfigSvcConfigToJson(ConfigSvcConfig entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

extension ConfigSvcConfigExtension on ConfigSvcConfig {}
