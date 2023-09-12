import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/models/estado_model.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:autom_v3/view/estado/estado_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    Widget build(BuildContext context) => 
        Scaffold
        (
            appBar: AppBar
            (
                title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                backgroundColor: Colors.greenAccent,
            ),
            drawer: const NavigationPanel(),
            body: Center
            (
                child: SingleChildScrollView
                (
                    scrollDirection: Axis.vertical,
                    child: FutureBuilder
                    (
                        future: getEstadoList(),
                        builder: (context, snapshot)
                        {
                            if (snapshot.connectionState == ConnectionState.waiting)
                            {
                                return const CircularProgressIndicator();
                            }
                            else if(snapshot.hasError)
                            {
                                return Text('Error: ${snapshot.error}');
                            }
                            else
                            {
                                var rows =  snapshot.data!;
                                int? length = snapshot.data?.length ?? 0;

                                return DataTable
                                (
                                    columns: 
                                        const
                                        [
                                            DataColumn(label: Text('Sigla')),
                                            DataColumn(label: Text('Nome')),
                                        ],
                                    rows: List<DataRow>.generate
                                    (
                                        length,
                                        (index) => DataRow
                                        (
                                            cells: <DataCell>
                                            [
                                                DataCell
                                                (
                                                    Text(rows[index]['sigla'])
                                                ),
                                                DataCell
                                                (
                                                    Text(rows[index]['nome'])
                                                ),
                                            ]
                                        )
                                    )                
                                );

                            }
                        },
                    ),
                )
            )
        );
}