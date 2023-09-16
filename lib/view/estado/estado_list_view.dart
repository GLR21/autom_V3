import 'package:autom_v3/controllers/estado_controller.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:autom_v3/view/estado/estado_view.dart';
import 'package:flutter/material.dart';

class EstadoListView extends StatefulWidget
{
    const EstadoListView({Key? key}): super(key: key);

    @override
    State<StatefulWidget> createState() => _EstadoListViewState();
}

class _EstadoListViewState extends State<EstadoListView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? sigla;
    String? nome;
    String? codIbge;

    Widget buildFieldSigla()
    {
        return TextFormField
        (
            decoration: const InputDecoration(label: Text('Sigla')),
            validator: (String? value)
            {
                return null;
            },
            onSaved: (newValue)
            {
                sigla = newValue;
            },
        );
    }

    Widget buildFieldNome()
    {
        return TextFormField
        (
            decoration: const InputDecoration(label: Text('Nome')),
            validator: (String? value)
            {
                return null;
            },
            onSaved: (newValue)
            {
                nome = newValue;
            },
        );
    }

    Widget buildFieldCodIbge()
    {
        return TextFormField
        (
            decoration: const InputDecoration(label: Text('Código IBGE')),
            validator: (String? value)
            {
                return null;
            },
            onSaved: (newValue)
            {
                codIbge = newValue;
            },
        );
    }

    @override
    Widget build(BuildContext context) => 
        Scaffold
        (
            key: scaffoldKey,
            appBar: AppBar
            (
                title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                backgroundColor: Colors.greenAccent,
            ),
            drawer: const NavigationPanel(),
            body: Scaffold
            (
                body: Wrap
                (
                    children:
                    [
                        Container
                        (
                            margin: const EdgeInsets.all(0),
                            child: Form
                            (
                                key: formKey,
                                child: Column
                                (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>
                                    [
                                        Padding
                                        (
                                            padding: const EdgeInsets.all(32),
                                            child: Column
                                            (
                                                children:
                                                [
                                                    buildFieldSigla(),
                                                    buildFieldNome(),
                                                    buildFieldCodIbge()
                                                ],                                            
                                            ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(32),
                                          child: Row
                                          (
                                              children:
                                              [
                                                  ElevatedButton
                                                  (
                                                      child: const Text
                                                      (
                                                          'Buscar',
                                                          style: TextStyle(color: Colors.green),
                                                      ),
                                                      onPressed: ()
                                                      {
                                                          if(!formKey.currentState!.validate())
                                                          {
                                                              return;
                                                          }
                                        
                                                          formKey.currentState!.save();
                                        
                                                          print(nome);
                                                          print(sigla);
                                                      },
                                                  ),
                                                  const Padding
                                                  (
                                                      padding: EdgeInsets.all(5)
                                                  ),
                                                  ElevatedButton
                                                  (
                                                      onPressed: ()
                                                      {
                                                          Navigator.of(context).push
                                                          (
                                                              MaterialPageRoute
                                                              (
                                                                  builder: (context) => const EstadoView(null),
                                                              ),
                                                          );
                                                      },
                                                      child: const Text
                                                      (
                                                          'Cadastrar',
                                                          style: TextStyle(color: Colors.green),
                                                      ),
                                                  ),
                                              ],
                                          ),
                                        )
                                    ],
                                )
                            ),
                        ),
                        Center
                        (
                            child: FutureBuilder
                            (
                                future: EstadoController().getEstadoList(),
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
                                        var dts = DTS(context, rows);
                                        int? rowPerPage = PaginatedDataTable.defaultRowsPerPage;
                        
                                        return PaginatedDataTable(
                                            header: const Text('Estados'),
                                            columns: const
                                            [
                                                DataColumn(label: Text('Sigla')),
                                                DataColumn(label: Text('Nome')),
                                                DataColumn(label: Text('Editar')),
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
                        ),
                    ]
                )
            )
        );
}

class DTS extends DataTableSource
{
    BuildContext context;
    var rows = [];

    DTS
    (
        this.context,
        this.rows
    );

    @override
    DataRow? getRow(int index)
    {
        return DataRow.byIndex
        (
            index: index,
            cells: 
            [
                DataCell(Text(rows[index]['sigla'])),
                DataCell(Text(rows[index]['nome'])),
                DataCell
                (
                    ElevatedButton
                    (
                        onPressed: ()
                        {
                            Navigator.of(context).push
                            (
                                MaterialPageRoute
                                (
                                    builder: (context) => EstadoView(rows[index]['id']),
                                ),
                            );
                        },
                        child: const Text
                        (
                            'Editar',
                            style: TextStyle(color: Colors.green),
                        ),
                    ),
                )
            ],
        );
    }

    @override
    bool get isRowCountApproximate => false;

    @override
    int get rowCount => rows.length;

    @override
    int get selectedRowCount => 0;
}