import 'package:flutter/material.dart';
import 'package:newbug/core/widget/intro/flutter_intro.dart';

class DemoUsage extends StatefulWidget {
  const DemoUsage({super.key});

  @override
  State<DemoUsage> createState() => _DemoUsageState();
}

class _DemoUsageState extends State<DemoUsage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: IntroStepBuilder(
                  /*overlayBuilder: (StepWidgetParams params) => Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "'I can help you quickly implement the Step By Step guide in the Flutter project.'",
                      style: TextStyle(fontSize: 16, color: Colors.cyan),
                    ),
                  ),*/
                  /* onHighlightWidgetTap: () {
                    // Intro.of(context).start();
                    debugPrint("===>>>ooooooo");
                    //Intro.of(context).start();
                  },*/
                  order: 2,
                  text:
                      'I can help you quickly implement the Step By Step guide in the Flutter project.',
                  builder: (context, key) =>
                      Placeholder(key: key, fallbackHeight: 100),
                ),
              ),
              const SizedBox(height: 16),
              IntroStepBuilder(
                order: 3,
                text:
                    'My usage is also very simple, you can quickly learn and use it through example and api documentation.',
                builder: (context, key) =>
                    Placeholder(key: key, fallbackHeight: 100),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: IntroStepBuilder(
                order: 1,
                text: 'Welcome to flutter_intro',
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  top: 8,
                ),
                onWidgetLoad: () {
                  Intro.of(context).start();
                },
                builder: (context, key) => Icon(Icons.home, key: key),
              ),
            ),
            const BottomNavigationBarItem(
              label: 'Book',
              icon: Icon(Icons.book),
            ),
            const BottomNavigationBarItem(
              label: 'School',
              icon: Icon(Icons.school),
            ),
          ],
        ),
      ),
    );
  }
}
