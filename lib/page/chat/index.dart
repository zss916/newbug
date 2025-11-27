library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/config/form_type.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/im/cv_im.dart';
import 'package:newbug/core/im/utils/im_event.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/private_msg_status_entity.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/reopsitory/chat.dart';
import 'package:newbug/core/network/reopsitory/system.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/chat/chat_widget/chat.dart';
import 'package:newbug/page/chat/chat_widget/chat_action_mixin.dart';
import 'package:newbug/page/chat/chat_widget/local_wrapper_msg.dart';
import 'package:newbug/page/chat/sheet/sheetChatMore.dart';
import 'package:newbug/page/chat/widget/chat_app_bar.dart';
import 'package:newbug/page/chat/widget/float_card.dart';
import 'package:newbug/page/dialog/block/block_dialog.dart';
import 'package:newbug/page/dialog/remove/remove_conversation_dialog.dart';
import 'package:newbug/page/dialog/report/sheet_report.dart';
import 'package:newbug/page/login/photo/mixin_upload.dart';
import 'package:rongcloud_im_wrapper_plugin/rongcloud_im_wrapper_plugin.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'custom_message_widget/message_wrapper_widget.dart' show MsgStatus;

part 'chat_logic.dart';
part 'chat_view.dart';
