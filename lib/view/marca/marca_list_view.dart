import 'package:autom_v3/classes/marca.dart';
import 'package:autom_v3/controllers/marca_controller.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:autom_v3/view/marca/marca_view.dart';
import 'package:flutter/material.dart';

class MarcaListView extends StatefulWidget
{
    const MarcaListView({Key? key}): super(key: key);

    @override
    State<StatefulWidget> createState() => _MarcaListViewState();
}

class _MarcaListViewState extends State<MarcaListView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<List> filteredList = MarcaController().getAll();

    String? id;
    String? nome;

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

    @override
    Widget build(BuildContext context)
    {
        Scaffold scaffold = Scaffold
        (
            key: scaffoldKey,
            drawer: const NavigationPanel(),
            appBar: AppBar
            (
                title: const Text('Marcas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
                                                        Marca marca = Marca
                                                        (
                                                            nome ?? '',
                                                            id
                                                        );

                                                        setState(()
                                                        {
                                                            filteredList = MarcaController().getFiltered(marca);
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
                                                                builder: (context) => const MarcaView(null),
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
                                        builder: (context) => MarcaView(id),
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
                                        content: const Text('Deseja remover a Marca?'),
                                        actions:
                                        [
                                            ElevatedButton
                                            (
                                                onPressed: ()
                                                {
                                                    MarcaController().delete(Marca.byId(id));
                                                    
                                                    Navigator.of(context).push
                                                    (
                                                        MaterialPageRoute
                                                        (
                                                            builder: (context) => const MarcaListView()
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