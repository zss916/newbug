part of 'index.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({super.key});

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
            PositionedDirectional(
              top: 0,
              child: GetBuilder<LaunchLogic>(
                init: LaunchLogic(),
                builder: (logic) => LoginBg(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
