import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/models/estado_model.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:flutter/material.dart';

class EstadoListView extends StatelessWidget {

    const EstadoListView({Key? key}): super(key: key);

    Future<List> getEstadoList() async
    {
        List list = await EstadoModel().selectAll();
        list.map((e) => 
            Estado.empty().toObject(e)
        ).toList();

        return list;
    }

    @override
    Widget build(BuildContext context) {

        Scaffold scaffold = Scaffold(
            appBar: AppBar(
                title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                backgroundColor: Colors.greenAccent,
            ),
            drawer: const NavigationPanel(),
            body: Center(
                child: FutureBuilder(
                    future: getEstadoList(),
                    builder: (context, snapshot)
                    {
                        if (snapshot.connectionState == ConnectionState.waiting)
                        {
                            return const CircularProgressIndicator();
                        }
                        else if(snapshot.hasError)
                        {
                            return Text('Erro: ${snapshot.error}');
                        }
                        else
                        {
                            return Center(
                                child: ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                        return Text(snapshot.data?[index]['nome']!);
                                    }
                                ),
                            );
                        }
                    },
                ),
            )
        );

        return scaffold;
    }
}