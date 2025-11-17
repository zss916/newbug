import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newbug/core/config/translation/index.dart';
import 'package:newbug/core/event/app_event.dart';
import 'package:newbug/core/helper/auth_helper.dart';
import 'package:newbug/core/stores/event.dart';
import 'package:newbug/core/widget/intro/flutter_intro.dart';
import 'package:newbug/generated/assets.dart';

class PieMenu extends StatefulWidget {
  final double radius;
  final double offset;
  final Function(bool)? onToggle;
  final Function? onNext;
  final Function? onChat;
  final Function? onLike;
  final bool isOpen;

  const PieMenu({
    super.key,
    required this.radius,
    required this.offset,
    required this.onToggle,
    this.onChat,
    this.onLike,
    this.onNext,
    this.isOpen = false,
  });

  @override
  State<PieMenu> createState() => _PieMenuState();
}

class _PieMenuState extends State<PieMenu> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  double defaultOffest = 0.135; //0.3

  StreamSubscription<OpenMenuEvent>? subs;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.fastOutSlowIn,
      ),
    );
    _animationController.addListener(listener);
    _animationController.addStatusListener(statusListener);

    super.initState();
    if (widget.isOpen) {
      _animationController.forward();
    }

    EventService.to.listen<OpenMenuEvent>((event) {
      if (event.isOpen) {
        _animationController.forward();
        Intro.of(context).start();
      }
    });
  }

  late VoidCallback listener = () {
    if (mounted) {
      setState(() {});
    }
  };

  AnimationStatusListener statusListener = (status) {
    debugPrint("status ==> ${status.name}");
  };

  @override
  void dispose() {
    widget.onToggle?.call(false);
    _animationController.removeListener(listener);
    _animationController.removeStatusListener(statusListener);
    if (isFirst) {
      Intro.of(context).dispose();
    }
    _animationController.dispose();
    subs?.cancel();
    super.dispose();
  }

  bool get isFirst => !AuthHelper.instance.isFinishGuide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (90 + 35 + 24),
      height: 180,
      // color: Colors.transparent,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          buildStep2(
            isFirst: isFirst,
            onSkip: () {
              AuthHelper.instance.setGuideStatus(true);
            },
          ),

          if (widget.offset != defaultOffest)
            buildStep3(
              isFirst: isFirst,
              onSkip: () {
                AuthHelper.instance.setGuideStatus(true);
              },
            ),

          buildStep4(
            isFirst: isFirst,
            onSkip: () {
              AuthHelper.instance.setGuideStatus(true);
            },
          ),

          buildStep1(
            isFirst: isFirst,
            onSkip: () {
              AuthHelper.instance.setGuideStatus(true);
            },
          ),
        ],
      ),
    );
  }

  //AuthHelper
  Widget buildStep1({bool isFirst = true, Function? onSkip}) {
    return isFirst
        ? IntroStepBuilder(
            order: 1,
            getOverlayPosition:
                ({
                  required Offset offset,
                  required Size screenSize,
                  required Size size,
                }) {
                  return OverlayPosition(
                    top:
                        Get.statusBarHeight +
                        ((Get.width - 28.w - 4) * 483 / 362) -
                        250.h,
                    right: 35.w,
                    width: 300.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
            overlayBuilder: (params) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PositionedDirectional(
                    end: 5.w,
                    bottom: 18.h,
                    child: Image.asset(
                      Assets.decorationArrow,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(bottom: 30.h),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7DEF9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 14.w,
                      end: 14.w,
                      top: 12.h,
                      bottom: 12.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(end: 3.w),
                              child: Image.asset(
                                Assets.imgFab,
                                width: 18,
                                height: 18,
                              ),
                            ),
                            Text(
                              T.react.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                params.onFinish();
                                _animationController.reverse();
                                onSkip?.call();
                              },
                              child: Text(
                                T.skip.tr,
                                style: TextStyle(
                                  color: const Color(0xFF6B6B6B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 4.h),
                          width: double.maxFinite,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: T.step1A.tr,
                                  style: TextStyle(
                                    color: const Color(0xFF310035),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: T.step1B.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: T.step1C.tr,
                                  style: TextStyle(
                                    color: const Color(0xFF310035),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 16.h),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: params.onNext,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF7E48FE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    T.nextStep.trArgs(["1"]),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            builder: (context, key) => buildFab(key: key),
          )
        : buildFab();
  }

  Widget buildFab({GlobalKey? key}) => GestureDetector(
    onTap: () {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }

      if (widget.onToggle != null) {
        widget.onToggle?.call(
          _animationController.status == AnimationStatus.forward,
        );
      }
    },
    child: Image.asset(Assets.imgFab, width: 70, height: 70, key: key),
  );

  Widget buildStep2({bool isFirst = true, Function? onSkip}) {
    return isFirst
        ? IntroStepBuilder(
            order: 2,
            getOverlayPosition:
                ({
                  required Offset offset,
                  required Size screenSize,
                  required Size size,
                }) {
                  return OverlayPosition(
                    top:
                        Get.statusBarHeight +
                        ((Get.width - 28.w - 4) * 483 / 362) -
                        270.h,
                    left: 48.w,
                    width: 280.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
            overlayBuilder: (params) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PositionedDirectional(
                    end: 5.w,
                    bottom: 18.h,
                    child: Image.asset(
                      Assets.decorationArrow,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(bottom: 30.h),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7DEF9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 14.w,
                      end: 14.w,
                      top: 12.h,
                      bottom: 12.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(end: 3.w),
                              child: Image.asset(
                                Assets.imgFabLike,
                                width: 18,
                                height: 18,
                              ),
                            ),
                            Text(
                              T.like.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                params.onFinish();
                                _animationController.reverse();
                                onSkip?.call();
                              },
                              child: Text(
                                T.skip.tr,
                                style: TextStyle(
                                  color: const Color(0xFF6B6B6B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 4.h),
                          width: double.maxFinite,
                          child: Text(
                            T.step2.tr,
                            style: TextStyle(
                              color: const Color(0xFF310035),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 16.h),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: params.onNext,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF7E48FE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    T.nextStep.trArgs(["2"]),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            builder: (context, key) => buildLike(key: key),
          )
        : buildLike();
  }

  Widget buildLike({GlobalKey? key}) => Transform.translate(
    offset: Offset.fromDirection(
      widget.offset * math.pi + math.pi,
      _animation.value * widget.radius,
    ),
    child: Transform.scale(
      scale: _animation.value,
      child: Transform.rotate(
        angle: _animation.value * (math.pi * 2),
        child: InkWell(
          onTap: () {
            debugPrint("like");
            if (_animationController.status == AnimationStatus.completed) {
              _animationController.reverse();
              if (widget.onLike != null) {
                widget.onLike?.call();
              }
            }
          },
          child: Image.asset(
            Assets.imgFabLike,
            width: 48,
            height: 48,
            key: key,
          ),
        ),
      ),
    ),
  );

  Widget buildStep3({bool isFirst = true, Function? onSkip}) {
    return isFirst
        ? IntroStepBuilder(
            order: 3,
            getOverlayPosition:
                ({
                  required Offset offset,
                  required Size screenSize,
                  required Size size,
                }) {
                  return OverlayPosition(
                    top:
                        Get.statusBarHeight +
                        ((Get.width - 28.w - 4) * 483 / 362) -
                        180.h,
                    left: 14.w,
                    width: 280.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
            overlayBuilder: (params) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PositionedDirectional(
                    end: 5.w,
                    bottom: 18.h,
                    child: Image.asset(
                      Assets.decorationArrow,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(bottom: 30.h),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7DEF9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 14.w,
                      end: 14.w,
                      top: 12.h,
                      bottom: 12.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(end: 3.w),
                              child: Image.asset(
                                Assets.imgFabMsg,
                                width: 18,
                                height: 18,
                              ),
                            ),
                            Text(
                              T.chat.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                params.onFinish();
                                _animationController.reverse();
                                onSkip?.call();
                              },
                              child: Text(
                                T.skip.tr,
                                style: TextStyle(
                                  color: const Color(0xFF6B6B6B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 4.h),
                          width: double.maxFinite,
                          child: Text(
                            T.step3.tr,
                            style: TextStyle(
                              color: const Color(0xFF310035),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 16.h),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: params.onNext,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF7E48FE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    T.nextStep.trArgs(["3"]),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            builder: (context, key) => buildChat(key: key),
          )
        : buildChat();
  }

  Widget buildChat({GlobalKey? key}) => Transform.translate(
    offset: Offset.fromDirection(math.pi, _animation.value * widget.radius),
    child: Transform.scale(
      scale: _animation.value,
      child: Transform.rotate(
        angle: _animation.value * (math.pi * 2),
        child: InkWell(
          onTap: () {
            debugPrint("chat");
            if (_animationController.status == AnimationStatus.completed) {
              _animationController.reverse();
              if (widget.onChat != null) {
                widget.onChat?.call();
              }
            }
          },
          child: Image.asset(Assets.imgFabMsg, width: 48, height: 48, key: key),
        ),
      ),
    ),
  );

  Widget buildStep4({bool isFirst = true, Function? onSkip}) {
    return isFirst
        ? IntroStepBuilder(
            order: 4,
            getOverlayPosition:
                ({
                  required Offset offset,
                  required Size screenSize,
                  required Size size,
                }) {
                  return OverlayPosition(
                    top:
                        Get.statusBarHeight +
                        ((Get.width - 28.w - 4) * 483 / 362) -
                        140.h,
                    left: 30.w,
                    width: 300.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
            overlayBuilder: (params) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  PositionedDirectional(
                    end: 5.w,
                    bottom: 18.h,
                    child: Image.asset(
                      Assets.decorationArrow,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(bottom: 30.h),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7DEF9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsetsDirectional.only(
                      start: 14.w,
                      end: 14.w,
                      top: 12.h,
                      bottom: 12.h,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(end: 3.w),
                              child: Image.asset(
                                Assets.imgFabClose,
                                width: 18,
                                height: 18,
                              ),
                            ),
                            Text(
                              T.next.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                params.onFinish();
                                _animationController.reverse();
                                onSkip?.call();
                              },
                              child: Text(
                                T.skip.tr,
                                style: TextStyle(
                                  color: const Color(0xFF6B6B6B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 4.h),
                          width: double.maxFinite,
                          child: Text(
                            T.step4.tr,
                            style: TextStyle(
                              color: const Color(0xFF310035),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(top: 16.h),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  params.onFinish();
                                  _animationController.reverse();
                                  onSkip?.call();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 7,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF7E48FE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    T.nextStep.trArgs(["4"]),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            builder: (context, key) => buildNext(key: key),
          )
        : buildNext();
  }

  Widget buildNext({GlobalKey? key}) => Transform.translate(
    offset: Offset.fromDirection(
      -widget.offset * math.pi + math.pi,
      _animation.value * widget.radius,
    ),
    child: Transform.scale(
      scale: _animation.value,
      child: Transform.rotate(
        angle: _animation.value * (math.pi * 2),
        child: InkWell(
          onTap: () {
            debugPrint("next");
            if (_animationController.status == AnimationStatus.completed) {
              _animationController.reverse();
              if (widget.onNext != null) {
                widget.onNext?.call();
              }
            }
          },
          child: Image.asset(
            Assets.imgFabClose,
            width: 48,
            height: 48,
            key: key,
          ),
        ),
      ),
    ),
  );
}
