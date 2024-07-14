import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:led_dign_app/pages/index.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LED Sign',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigoAccent,
        ),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => const CrudSentencesPage(),
        "/show-animate-sentence": (BuildContext ctx) {
          final args = ModalRoute.of(ctx)!.settings.arguments as String;
          return ShowAnimateSentencePage(textToShow: args);
        }
      },
      // home: const Scaffold(
      //   body: Center(
      //     child: Text('Page name'),
      //   ),
      // ),
    );
  }
}
