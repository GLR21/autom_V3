
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget
{
    const MainView({super.key});

    static const String title = 'Autom';

    @override
    Widget build(BuildContext context) => Scaffold
    (
        appBar: AppBar
        (
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text
            (
                MainView.title,
                style: TextStyle
                (
                    color: Colors.white, fontWeight: FontWeight.w500
                ),
            )
        ),
        drawer: const NavigationPanel(),
        body: const Center
        (
            child: Text('Página em branco')
        ),
    );
}
