part of 'index.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notTitleAppBar,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: GradientContainer(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            PositionedDirectional(top: 0, child: LoginBg()),
            Column(
              children: [
                Spacer(),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: double.infinity,
                  margin: EdgeInsetsDirectional.only(
                    bottom: 30.h,
                    start: 20,
                    end: 20,
                  ),
                  child: Text(
                    App.name,
                    style: TextStyle(
                      color: const Color(0xFF262626),
                      fontSize: 32.sp,
                      fontFamily: AppFonts.font1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                CustomBorderButton(
                  margin: EdgeInsetsDirectional.only(
                    bottom: 20.h,
                    start: 32.w,
                    end: 32.w,
                  ),
                  border: Border.all(width: 1, color: Color(0xFFFF0092)),
                  bgColor: Color(0xFFFF0092),
                  title: T.googleLogin.tr,
                  textColor: Colors.white,
                  icon: Assets.imgGoogleW,
                  onTap: () {
                    //CustomToast.text("yyyyyyy");
                    RouteManager.intoInitApp();
                    //RouteManager.toMain();
                  },
                ),
                CustomBorderButton(
                  margin: EdgeInsetsDirectional.only(
                    bottom: 20.h,
                    start: 32.w,
                    end: 32.w,
                  ),
                  title: T.emailLogin.tr,
                  icon: Assets.imgEmail,
                  onTap: () {
                    RouteManager.toEmailLogin();
                  },
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(
                    bottom: 42.h,
                    start: 24.w,
                    end: 24.w,
                    top: 20.h,
                  ),
                  width: double.maxFinite,
                  child: TermsAndPolicy(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
