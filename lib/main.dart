import 'package:autom_v3/view/principal_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async
{
    await dotenv.load(fileName: ".env");
    runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) => MaterialApp(
        title: PrincipalView.title,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.greenAccent
            ),
            useMaterial3: true,
        ),
        home: const PrincipalView(),
    );
}
