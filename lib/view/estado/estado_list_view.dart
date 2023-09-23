import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/controllers/estado_controller.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
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

    Future<List> filteredList = EstadoController().getAll();

    String? id;
    String? sigla;
    String? nome;
    String? codIbge;

    Widget buildFieldId()
    {
        return SizedBox
        (
            width: 100,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text('Código'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    id = newValue;
                },
            ),
        );
    }

    Widget buildFieldSigla()
    {
        return SizedBox
        (
            width: 100,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text('Sigla'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    sigla = newValue;
                },
            ),
        );
    }

    Widget buildFieldNome()
    {
        return SizedBox
        (
            width: 300,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text
                    (
                        'Nome'
                    ),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    nome = newValue;
                }
            ),
        );
    }

    Widget buildFieldCodIbge()
    {
        return SizedBox
        (
            width: 136,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text('Código IBGE'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    codIbge = newValue;
                },
            ),
        );
    }

    @override
    Widget build(BuildContext context)
    {
        Scaffold scaffold = Scaffold
        (
            key: scaffoldKey,
            drawer: const NavigationPanel(),
            appBar: AppBar
            (
                title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                backgroundColor: Colors.greenAccent,
            ),
            body: 
            SingleChildScrollView
            (
                scrollDirection: Axis.vertical,
                child:
                Wrap
                (
                    children:
                    [
                        Form
                        (
                            key: formKey,
                            child: Row
                            (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>
                                [
                                    Column
                                    (
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:
                                        [
                                            buildFieldId()
                                        ]
                                    ),
                                    const Padding(padding: EdgeInsets.all(5),),
                                    Column
                                    (
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:
                                        [
                                            buildFieldSigla()
                                        ]
                                    ),
                                    const Padding(padding: EdgeInsets.all(5),),
                                    Column
                                    (
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:
                                        [
                                            buildFieldNome()
                                        ]
                                    ),
                                    const Padding(padding: EdgeInsets.all(5),),
                                    Column
                                    (
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:
                                        [
                                            buildFieldCodIbge()
                                        ]
                                    ),
                                    Padding
                                    (
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

                                                        /*
                                                        * filtrar Estado
                                                        */
                                                        int? id = this.id != null && this.id != '' ? int.parse(this.id!) : 0;
                                                        Estado estado = Estado
                                                        (
                                                            nome ?? '',
                                                            sigla ?? '',
                                                            codIbge!.isEmpty ? 0 : int.parse(codIbge!),
                                                            id
                                                        );

                                                        setState(()
                                                        {
                                                            filteredList = EstadoController().getFiltered(estado);
                                                        });
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
                                                                builder: (context) => EstadoView(null),
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
                        FutureBuilder
                        (
                            future: filteredList,
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

                                    return Container
                                    (
                                        alignment: AlignmentDirectional.center,
                                        child: FittedBox
                                        (
                                            fit: BoxFit.fitWidth,
                                            child: Wrap
                                            (
                                                children:
                                                [
                                                    const SizedBox(),
                                                    SizedBox
                                                    (
                                                        width: MediaQuery.of(context).size.width/1.80,
                                                        child: PaginatedDataTable
                                                        (
                                                            columns: const
                                                            [
                                                                DataColumn(label: Text('Código')),
                                                                DataColumn(label: Text('Sigla')),
                                                                DataColumn(label: Text('Nome')),
                                                                DataColumn(label: Text('IBGE')),
                                                                DataColumn(label: Text('Editar')),
                                                                DataColumn(label: Text('Excluir')),
                                                            ],

                                                            source: dts,
                                                            onRowsPerPageChanged: (r)
                                                            {
                                                                rowPerPage = r;
                                                            },
                                                            rowsPerPage: rowPerPage,
                                                        )
                                                    ),
                                                    const SizedBox(),
                                                ],
                                            )
                                        )
                                    );
                                }
                            },
                        ),
                    ]
                )
            )
        );

        return scaffold;
    }
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
                DataCell(Text(rows[index]['id'].toString())),
                DataCell(Text(rows[index]['sigla'])),
                DataCell(Text(rows[index]['nome'])),
                DataCell(Text(rows[index]['cod_ibge'].toString())),
                DataCell
                (
                    Tooltip
                    (
                        message: 'Editar',
                        height: 40,
                        verticalOffset: 25,
                        child: ElevatedButton
                        (
                            onPressed: ()
                            {
                                var id = rows[index]['id'];

                                Navigator.of(context).push
                                (
                                    MaterialPageRoute
                                    (
                                        builder: (context) => EstadoView(id),
                                    ),
                                );
                            },
                            child: const  Icon
                            (
                                Icons.edit,
                                color: Colors.blueAccent
                            )
                        )
                    ),
                ),
                DataCell
                (
                    Tooltip
                    (
                        message: 'Excluir',
                        height: 40,
                        verticalOffset: 25,
                        child: ElevatedButton
                        (
                            onPressed: ()
                            {
                                var id = rows[index]['id'];

                                EstadoController().delete(Estado.byId(id));

                                DialogBuilder().showInfoDialog
                                (
                                    'Sucesso',
                                    'Estado excluído com sucesso',
                                    context
                                ).then((value) =>
                                    Navigator.of(context).push
                                    (
                                        MaterialPageRoute
                                        (
                                            builder: (context) => const EstadoListView()
                                        ),
                                    )
                                );
                            },
                            child: const  Icon
                            (
                                Icons.delete,
                                color: Colors.blueAccent
                            )
                        )
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