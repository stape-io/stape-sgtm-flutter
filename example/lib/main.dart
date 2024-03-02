import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:stape_sdk/stape_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Stape stape;
  late final FirebaseAnalyticsAdapter analytics;

  @override
  void initState() {
    stape = Stape.withOption(StapeOptions(domain: "yourdomain.com"));
    analytics = FirebaseAnalyticsAdapter(stape, FirebaseAnalytics.instance);

    super.initState();
  }

  sendStapeEvent() {
    stape.sendEvent("event1", {"userId": "cdd1eac3e254", "language": "en"});
    stape.sendEventData("event2", EventData(userId: "cdd1eac3e254", language: "en"));
  }

  sendFirebaseEvent() {
    analytics.logEvent(
      name: "event3",
      parameters: {"userId": "cdd1eac3e254", "language": "en"},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Container(),
        ),
      ),
    );
  }
}
