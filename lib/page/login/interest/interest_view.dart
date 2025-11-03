part of 'index.dart';

class InterestView extends StatelessWidget {
  const InterestView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InterestLogic>(
      init: InterestLogic(),
      builder: (logic) {
        return Scaffold(
          appBar: CommonAppBar(
            actions: [
              TextButton(
                onPressed: () {
                  logic.toSkip();
                },
                child: Text(
                  T.skip.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(child: InterestBody(logic: logic)),
        );
      },
    );
  }
}
