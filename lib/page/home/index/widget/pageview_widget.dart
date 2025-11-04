import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
import 'package:newbug/core/network/model/meida_list_item.dart';
import 'package:newbug/core/route/index.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/page/dialog/love/dialog_love.dart';
import 'package:newbug/page/dialog/next/dialog_next.dart';
import 'package:newbug/page/home/index/home_logic.dart';
import 'package:newbug/page/home/index/widget/home_about_me.dart';
import 'package:newbug/page/home/index/widget/home_bottom_menu.dart';
import 'package:newbug/page/home/index/widget/home_card.dart';
import 'package:newbug/page/home/index/widget/home_interests.dart';
import 'package:newbug/page/home/index/widget/home_profile.dart';
import 'package:newbug/page/home/index/widget/swiper_and_play_widget.dart'
    show SwiperAndPlayWidget;

class PageViewWidget extends StatefulWidget {
  final ScrollController controller;
  final bool isShowBottomMenu;
  final HomeLogic logic;

  const PageViewWidget({
    super.key,
    required this.controller,
    required this.isShowBottomMenu,
    required this.logic,
  });

  @override
  State<PageViewWidget> createState() => _PageviewWidgetState();
}

class _PageviewWidgetState extends State<PageViewWidget> {
  PageController controller = PageController();
  int selectIndex = 0;
  StreamSubscription<HomeMenuAction>? subs;

  @override
  void initState() {
    super.initState();
    subs = EventService.to.listen<HomeMenuAction>((event) {
      switch (event.action) {
        case MenuActionEmu.like:
          toLikeAction();
          break;
        case MenuActionEmu.flashChat:
          toFlashChat(matchValue: widget.logic.data[selectIndex]);
          break;
        case MenuActionEmu.next:
          toNextAction();
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subs?.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.logic.data.length,
      onPageChanged: (index) {
        widget.logic.selected = index;
      },
      itemBuilder: (context, index) {
        HomeCardsMatchList item = widget.logic.data[index];
        return SingleChildScrollView(
          //  physics: ClampingScrollPhysics(),
          controller: widget.controller,
          child: Column(
            children: [
              buildCard(cards: item.mediaList ?? []),
              HomeProfile(item: item),
              HomeAboutMe(sign: item.sign ?? ""),
              HomeInterests(tags: item.tags ?? []),
              if (widget.isShowBottomMenu)
                HomeBottomMenu(
                  onChat: () {
                    toFlashChat(matchValue: item);
                  },
                  onNext: () {
                    toNextAction();
                  },
                  onLike: () {
                    toLikeAction();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCard({required List<MediaListItem> cards}) {
    return HomeCard(child: SwiperAndPlayWidget(items: [...cards]));
  }

  void toNextAction() {
    if (selectIndex + 1 < widget.logic.data.length) {
      selectIndex++;
      showNextDialog().whenComplete(() {
        controller.jumpToPage(selectIndex);
      });
    } else {
      debugPrint("最后一个");
    }
  }

  void toLikeAction() {
    if (selectIndex + 1 < widget.logic.data.length) {
      selectIndex++;
      showLoveDialog().whenComplete(() {
        controller.jumpToPage(selectIndex);
      });
    } else {
      debugPrint("最后一个");
    }
  }

  void toFlashChat({required HomeCardsMatchList matchValue}) {
    RouteManager.toFlashChat(value: matchValue);
  }
}
