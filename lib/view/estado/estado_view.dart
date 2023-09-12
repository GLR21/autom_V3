import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:flutter/material.dart';

class EstadoView extends StatelessWidget {
    
    final int? id;

    const EstadoView(this.id, {super.key});

    @override
    Widget build(BuildContext context) {

        String id = this.id.toString();

        Scaffold scaffold = Scaffold(
            appBar: AppBar(
                title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                backgroundColor: Colors.greenAccent,
            ),
            drawer: const NavigationPanel(),
            body: Center(
                child: Text('Estado View: $id')
            ),
        );

        return scaffold;
    }
}