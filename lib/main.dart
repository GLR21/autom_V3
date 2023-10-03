import 'package:autom_v3/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

Future<void> main() async
{
    await dotenv.load(fileName: ".env");

    runApp(const MyApp());

    doWhenWindowReady(()
        {
            const initialSize = Size(1440, 900);
            appWindow.minSize = const Size(1280,720);
            appWindow.size = initialSize;
            appWindow.alignment = Alignment.center;
            appWindow.show();
        }
    );
}

class MyApp extends StatelessWidget
{
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) => MaterialApp(
        title: MainView.title,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.greenAccent
            ),
            useMaterial3: true,
        ),
        home: const MainView(),
    );
}
