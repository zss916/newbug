part of 'index.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: T.notification.tr),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(children: []),
    );
  }
}
