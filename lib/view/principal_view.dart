
import 'package:autom_v3/view/components/painel_navegacao.dart';
import 'package:flutter/material.dart';

class PrincipalView extends StatelessWidget
{
    const PrincipalView({super.key});

    static const String title = 'Autom';

@override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(PrincipalView.title),
        ),
        drawer: const PainelNavegacao(),
        body: const Center(
            child: Text('Página em branco')
        ),
    );
}

