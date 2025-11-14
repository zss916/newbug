library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/album/gallery/gallery_tools.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/helper/date_helper.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/network/model/user_entity.dart';
import 'package:newbug/core/network/model/user_info.dart';
import 'package:newbug/core/network/reopsitory/account.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/app_stores.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:newbug/page/login/photo/mixin_upload.dart';
import 'package:newbug/page/login/photo/widget/photo_card.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'photo_logic.dart';
part 'photo_view.dart';
