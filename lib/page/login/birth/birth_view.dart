part of 'index.dart';

class BirthView extends StatelessWidget {
  const BirthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: Colors.white,
      body: GetBuilder<BirthLogic>(
        init: BirthLogic(),
        builder: (logic) {
          return SelectBirthBody(
            birthDateTimr: logic.birthDateTime,
            logic: logic,
          );
        },
      ),
    );
  }
}
