import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:newbug/core/config/action_type.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/network/model/home_cards_entity.dart';
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
          toFlashChat(matchValue: widget.logic.matchList[selectIndex]);
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
      itemCount: widget.logic.matchList.length,
      onPageChanged: (index) {
        widget.logic.selected = index;
      },
      itemBuilder: (context, index) {
        HomeCardsMatchList item = widget.logic.matchList[index];
        return SingleChildScrollView(
          //  physics: ClampingScrollPhysics(),
          controller: widget.controller,
          child: Column(
            children: [
              buildCard(item: item),
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

  Widget buildCard({required HomeCardsMatchList item}) {
    return HomeCard(
      child: SwiperAndPlayWidget(
        data: item,
        items: [...(item.mediaList ?? [])],
      ),
    );
  }

  void toNextAction() {
    if (selectIndex + 1 < widget.logic.matchList.length) {
      selectIndex++;
      showNextDialog().whenComplete(() {
        controller.jumpToPage(selectIndex);
      });
      widget.logic.chooseUser(type: ActionType.pass);
    } else {
      EventService.to.post(HomeMenuEvent(isShow: false));
      widget.logic.toUnMatchView();
    }
  }

  void toLikeAction() {
    if (selectIndex + 1 < widget.logic.matchList.length) {
      selectIndex++;
      showLoveDialog().whenComplete(() {
        controller.jumpToPage(selectIndex);
      });
      widget.logic.chooseUser(type: ActionType.like);
    } else {
      EventService.to.post(HomeMenuEvent(isShow: false));
      widget.logic.toUnMatchView();
    }
  }

  void toFlashChat({required HomeCardsMatchList matchValue}) {
    RouteManager.toFlashChat(value: matchValue);
  }
}
