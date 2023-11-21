import 'package:autom_v3/view/login_view.dart';
import 'package:autom_v3/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

Future<void> main() async
{
    // await initializeDateFormatting('pt_BR', null);

    await dotenv.load(fileName: ".env");
    runApp(const LoginScreen());

    doWhenWindowReady(()
        {
            const initialSize = Size(800, 600);
            appWindow.minSize = const Size(800, 600);
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
    Widget build(BuildContext context) => MaterialApp
    (
        title: MainView.title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData
        (
            colorScheme: ColorScheme.fromSeed
            (
                seedColor: Colors.greenAccent
            ),
            useMaterial3: true,
        ),
        home: const MainView(),
    );
}

class LoginScreen extends StatelessWidget
{
    const LoginScreen({super.key});

    @override
    Widget build(BuildContext context) => MaterialApp
    (
        title: LoginView.title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData
        (
            colorScheme: ColorScheme.fromSeed
            (
                background: Colors.greenAccent.withOpacity( 0.92 ),
                seedColor: Colors.greenAccent
            ),
            useMaterial3: true,
        ),
        home: const LoginView(),
    );
}
