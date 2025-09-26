import 'package:flutter/material.dart';
import 'package:newbug/core/widget/intro/flutter_intro.dart';
import 'package:newbug/test/advanced_usage.dart';
import 'package:newbug/test/demo_usage.dart';
import 'package:newbug/test/group_usage.dart';
import 'package:newbug/test/simple_usage.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Intro')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Intro(
                      padding: EdgeInsets.zero,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      maskColor: const Color.fromRGBO(0, 0, 0, .6),
                      child: const DemoUsage(),
                    ),
                  ),
                );
              },
              child: const Text('Demo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Intro(
                      buttonBuilder: (order) {
                        return IntroButtonConfig(
                          text: order == 3 ? 'Custom Button Text' : 'Next',
                          height: order == 3 ? 48 : null,
                          fontSize: order == 3 ? 24 : null,
                          style: order == 3
                              ? OutlinedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                )
                              : null,
                        );
                      },
                      child: const SimpleUsage(),
                    ),
                  ),
                );
              },
              child: const Text('Simple Usage'),
            ),
            ElevatedButton(
              child: const Text('Advanced Usage'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Intro(child: const AdvancedUsage()),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Group Usage'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Intro(child: const GroupUsage()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
