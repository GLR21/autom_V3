import 'package:autom_v3/classes/marca.dart';
import 'package:autom_v3/classes/peca.dart';
import 'package:autom_v3/controllers/marca_controller.dart';
import 'package:autom_v3/controllers/peca_controller.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:autom_v3/view/peca/peca_view.dart';
import 'package:flutter/material.dart';

class PecaListView extends StatefulWidget
{
    const PecaListView({Key? key}): super(key: key);

    @override
    State<StatefulWidget> createState() => _PecaListViewState();
}

class _PecaListViewState extends State<PecaListView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<List<dynamic>> allMarcas = MarcaController().getAll();
    Future<List> filteredList = PecaController().getAll();

    String? id;
    String? nome;
    String? descricao;
    String? valorCompra;
    String? valorRevenda;

    Object? selectedMarca;

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

    Widget buildFieldDescricao()
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
                        'Descrição'
                    ),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    descricao = newValue;
                }
            ),
        );
    }
 
    FutureBuilder buildComboMarcas()
    {
        return FutureBuilder<List<dynamic>>
        (
            future: allMarcas,
            builder: (context, snapshot)
            {
                if( snapshot.connectionState == ConnectionState.waiting )
                {}

                if(snapshot.hasError)
                {
                    return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData)
                {
                    var items = snapshot.data!;
                    var map = items.map((map) =>
                        DropdownMenuItem
                        (
                            value: map['id'],
                            child: Text(map['nome'])
                        )
                    );
                    var list = map.toList();
                    list.insert
                    (
                        0,
                        const DropdownMenuItem
                        (
                            value: 0,
                            child: Text('Selecione uma marca')
                        )
                    );

                    return DropdownButtonFormField
                    (
                        isExpanded: true,
                        value: 0,
                        hint: const Text('Selecione uma marca!'),
                        items: list,
                        onChanged: (value) => setState(()
                        {
                            selectedMarca = value;
                        }),
                        validator: (value)
                        {
                            if(value == null)
                            {
                                return 'Selecione uma marca!';
                            }
                            return null;
                        },
                        onSaved: (value)
                        {
                            selectedMarca = value;
                        },
                    );
                }
                else
                {
                    return DropdownButton
                    (
                        items: const [],
                        onChanged: (item) => setState(() {}),
                    );
                }
            },
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
                title: const Text('Peças', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
                                                    buildFieldDescricao()
                                                ]
                                            )
                                        ),
                                        const Flexible
                                        (
                                            child: Padding(padding: EdgeInsets.all(5),)
                                        ),
                                        Flexible
                                        (
                                            flex: 2,
                                            child:
                                            ListTile
                                            (
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                subtitle: buildComboMarcas()
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
                                                            * filtrar Peca
                                                            */
                                                            int? id = this.id != null && this.id != '' ? int.parse(this.id!) : 0;
                                                            Peca peca = Peca
                                                            (
                                                                nome ?? '',
                                                                descricao ?? '',
                                                                valorCompra != null && valorCompra != '' ? double.parse(valorCompra!) : 0.00,
                                                                valorRevenda != null && valorRevenda != '' ? double.parse(valorRevenda!) : 0.00,
                                                                selectedMarca == null ? 0 : selectedMarca as int,
                                                                id
                                                            );

                                                            setState(()
                                                            {
                                                                filteredList = PecaController().getFiltered(peca);
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
                                                                    builder: (context) => const PecaView(null),
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
                                    return Container();
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
                                            width: MediaQuery.of(context).size.width/1.17,
                                            child:
                                            PaginatedDataTable
                                            (
                                                columnSpacing: 0.01,
                                                columns: const
                                                [
                                                    DataColumn
                                                    (
                                                        label: Padding
                                                        (
                                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                                            child: Text('Código')
                                                        ),
                                                    ),
                                                    DataColumn
                                                    (
                                                        label: Padding
                                                        (
                                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                                            child: Text('Nome')
                                                        ),
                                                    ),
                                                    DataColumn
                                                    (
                                                        label: Padding
                                                        (
                                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                                            child: Text('Descrição')
                                                        ),
                                                    ),
                                                    DataColumn
                                                    (
                                                        label: Padding
                                                        (
                                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                                            child: Text('Marca')
                                                        ),
                                                    ),
                                                    DataColumn
                                                    (
                                                        label: Padding
                                                        (
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            child: Text('Valor Compra')
                                                        ),
                                                    ),
                                                    DataColumn
                                                    (
                                                        label: Padding
                                                        (
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            child: Text('Valor Revenda')
                                                        ),
                                                    ),
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
                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(rows[index]['id'].toString())
                    )
                ),
                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(rows[index]['nome'] ?? '')
                    )
                ),
                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(rows[index]['descricao'] ?? '')
                    )
                ),
                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: buidlCellMarca(rows[index]['ref_marca'])
                    )
                ),
                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(rows[index]['valor_compra'].toString())
                    )
                ),
                                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(rows[index]['valor_revenda'].toString())
                    )
                ),
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
                                        builder: (context) => PecaView(id),
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
                                        content: const Text('Deseja remover a peça?'),
                                        actions:
                                        [
                                            ElevatedButton
                                            (
                                                onPressed: ()
                                                {
                                                    PecaController().delete(Peca.byId(id));
                                    
                                                    Navigator.of(context).push
                                                    (
                                                        MaterialPageRoute
                                                        (
                                                            builder: (context) => const PecaListView()
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

    FutureBuilder buidlCellMarca(int id)
    {
        return FutureBuilder<Marca>
        (
            future: MarcaController().get(Marca.byId(id)),
            builder: (context, snapshot)
            {
                if( snapshot.connectionState == ConnectionState.waiting )
                {}

                if(snapshot.hasError)
                {
                    return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData)
                {
                    var nome = snapshot.data!.nome;
                    return Text(nome);
                }
                else
                {
                    return const Text('');
                }
            },
        );
    }
}