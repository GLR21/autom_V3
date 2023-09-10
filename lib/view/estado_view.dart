import 'package:autom_v3/view/components/painel_navegacao.dart';
import 'package:flutter/material.dart';

class EstadoView extends StatelessWidget {
    
    const EstadoView({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
            backgroundColor: Colors.greenAccent,
        ),
        drawer: const PainelNavegacao(),
        body: const Center(
            child: Text('Página em branco')
        ),
    );
}