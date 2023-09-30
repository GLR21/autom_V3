import 'package:autom_v3/classes/cidade.dart';
import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/controllers/cidade_controller.dart';
import 'package:autom_v3/controllers/estado_controller.dart';
import 'package:autom_v3/view/cidade/cidade_view.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:flutter/material.dart';

class CidadeListView extends StatefulWidget
{
    const CidadeListView({Key? key}): super(key: key);

    @override
    State<StatefulWidget> createState() => _EstadoListViewState();
}

class _EstadoListViewState extends State<CidadeListView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<List> filteredList = CidadeController().getAll();

    String? id;
    String? nome;
    String? codIbge;
    String? refEstado;

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

    Widget buildFieldEstado()
    {
        return SizedBox
        (
            width: 136,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text('Estado'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    refEstado = newValue;
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
                title: const Text('Cidades', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
                            child:
                            Padding
                            (
                                padding: const EdgeInsets.all(15),
                                child:
                                Row
                                (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>
                                    [
                                        Flexible
                                        (
                                            child: Column
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children:
                                                [
                                                    buildFieldId()
                                                ]
                                            )
                                        ),
                                        const Flexible
                                        (
                                            child: Padding(padding: EdgeInsets.all(5),)
                                        ),
                                        const Flexible
                                        (
                                            child: Padding(padding: EdgeInsets.all(5),)
                                        ),
                                        Flexible
                                        (
                                            child: Column
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children:
                                                [
                                                    buildFieldNome()
                                                ]
                                            )
                                        ),
                                        const Flexible
                                        (
                                            child:  Padding(padding: EdgeInsets.all(5),)
                                        ),
                                        Flexible
                                        (
                                            child: Column
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children:
                                                [
                                                    buildFieldCodIbge()
                                                ]
                                            )
                                        ),
                                        const Flexible
                                        (
                                            child: Padding(padding: EdgeInsets.all(5),)
                                        ),
                                        Flexible
                                        (
                                            child: Column
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children:
                                                [
                                                    buildFieldEstado()
                                                ]
                                            )
                                        ),
                                        const Flexible
                                        (
                                            child: Padding(padding: EdgeInsets.all(5),)
                                        ),
                                        Flexible
                                        (
                                            child: Column
                                            (
                                                children:
                                                [
                                                    ElevatedButton
                                                    (
                                                        style: ElevatedButton.styleFrom
                                                        (
                                                            backgroundColor: Colors.green,
                                                            foregroundColor: Colors.white,
                                                            shape: RoundedRectangleBorder
                                                            (
                                                                borderRadius: BorderRadius.circular(4.0),
                                                            ),
                                                        ),
                                                        child: const Text
                                                        (
                                                            'Buscar',
                                                            style: TextStyle(color: Colors.white),
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
                                                            Cidade cidade = Cidade
                                                            (
                                                                nome ?? '',
                                                                codIbge!.isEmpty ? '' : codIbge!,
                                                                refEstado!.isEmpty ? 0 : int.parse(refEstado!),
                                                                id
                                                            );

                                                            setState(()
                                                            {
                                                                filteredList = CidadeController().getFiltered(cidade);
                                                            });
                                                        },
                                                    ),
                                                ],
                                            ),
                                        ),
                                        const Flexible
                                        (
                                            child: Padding(padding: EdgeInsets.all(5),)
                                        ),
                                        Flexible
                                        (
                                            child: Column
                                            (
                                                children: [
                                                    ElevatedButton
                                                    (
                                                        style: ElevatedButton.styleFrom
                                                        (
                                                            backgroundColor: Colors.green,
                                                            foregroundColor: Colors.white,
                                                            shape: RoundedRectangleBorder
                                                            (
                                                                borderRadius: BorderRadius.circular(4.0),
                                                            ),
                                                        ),
                                                        child: const Text
                                                        (
                                                            'Cadastrar',
                                                            style: TextStyle(color: Colors.white),
                                                        ),
                                                        onPressed: ()
                                                        {
                                                            Navigator.of(context).push
                                                            (
                                                                MaterialPageRoute
                                                                (
                                                                    builder: (context) => const CidadeView(null),
                                                                ),
                                                            );
                                                        },
                                                    ),
                                                ],
                                            )
                                        )
                                    ],
                                ),
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
                                        child:
                                        SizedBox
                                        (
                                            width: MediaQuery.of(context).size.width/1.80,
                                            child:
                                            PaginatedDataTable
                                            (
                                                columnSpacing: 0.01,
                                                columns: const
                                                [
                                                    DataColumn(label: Text('Código')),
                                                    DataColumn(label: Text('Nome')),
                                                    DataColumn(label: Text('IBGE')),
                                                    DataColumn(label: Text('Estado')),
                                                    DataColumn(label: Text('Editar')),
                                                    DataColumn(label: Text('Excluir')),
                                                ],
                                                source: dts,
                                                onRowsPerPageChanged: (r)
                                                {
                                                    rowPerPage = r;
                                                },
                                                rowsPerPage: rowPerPage,
                                            ) ,
                                        ),
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
                DataCell(Text(rows[index]['nome'])),
                DataCell(Text(rows[index]['cod_ibge'].toString())),
                DataCell(Text(rows[index]['ref_estado'].toString())),
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
                                        builder: (context) => CidadeView(id),
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

                                showDialog
                                (
                                    context: context,
                                    builder: (context) => AlertDialog
                                    (
                                        title: const Text('Alerta!'),
                                        content: const Text('Deseja remover a Cidade?'),
                                        actions:
                                        [
                                            ElevatedButton
                                            (
                                                onPressed: ()
                                                {
                                                    CidadeController().delete(Cidade.byId(id));
                                    
                                                    Navigator.of(context).push
                                                    (
                                                        MaterialPageRoute
                                                        (
                                                            builder: (context) => const CidadeListView()
                                                        ),
                                                    );
                                                },
                                                child: const Text('Sim')
                                            ),
                                            ElevatedButton
                                            (
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('Não')
                                            )
                                        ],
                                    ),
                                );
                            },
                            child: const  Icon
                            (
                                Icons.delete,
                                color: Color.fromARGB(255, 177, 0, 0)
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