import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/models/estado_model.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:flutter/material.dart';

class EstadoListView extends StatefulWidget {

    const EstadoListView({Key? key}): super(key: key);

    @override
    State<StatefulWidget> createState() => _EstadoListViewState();
}

class _EstadoListViewState extends State<EstadoListView>
{
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
                                var dts = DTS(rows);
                                int? rowPerPage = PaginatedDataTable.defaultRowsPerPage;

                                return PaginatedDataTable(
                                    header: const Text('Estados'),
                                    columns: const
                                    [
                                        DataColumn(label: Text('Sigla')),
                                        DataColumn(label: Text('Nome')),
                                    ],
                                    source: dts,
                                    onRowsPerPageChanged: (r)
                                    {
                                        rowPerPage = r;
                                    },
                                    rowsPerPage: rowPerPage,
                                );
                            }
                        },
                    ),
                )
            )
        );
}

class DTS extends DataTableSource
{
    var rows = [];

    DTS
    (
        this.rows
    );

    @override
    DataRow? getRow(int index)
    {
        if(index >= rows.length)
        {
            return null;
        }
    
        return DataRow.byIndex
        (
            index: index,
            cells: 
            [
                DataCell(Text(rows[index]['sigla'])),
                DataCell(Text(rows[index]['nome'])),
            ]
        );
    }

    @override
    bool get isRowCountApproximate => true;

    @override
    int get rowCount => 10;

    @override
    int get selectedRowCount => 0;
}