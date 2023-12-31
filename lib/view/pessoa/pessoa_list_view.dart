// ignore_for_file: sized_box_for_whitespace

import 'package:autom_v3/classes/cidade.dart';
import 'package:autom_v3/classes/peca.dart';
import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/controllers/cidade_controller.dart';
import 'package:autom_v3/controllers/peca_controller.dart';
import 'package:autom_v3/controllers/pessoa_controller.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:autom_v3/view/peca/peca_list_view.dart';
import 'package:autom_v3/view/pessoa/pessoa_view.dart';
import 'package:flutter/material.dart';

class PessoaListView extends StatefulWidget
{
    const PessoaListView({Key? key}): super(key: key);

    @override
    State<StatefulWidget> createState() => _PessoaListViewState();
}

class _PessoaListViewState extends State<PessoaListView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<List<dynamic>> allPessoas = PessoaController().getAll();
    Future<List<dynamic>> allCidades = CidadeController().getAll();
    Future<List> filteredList = PessoaController().getAll();

    String? id;
    String? nome;
    String? email;
    String? cep;
    String? bairro;
    String? tipoPessoa;

    Object? selectedTipoPessoa;
    Object? selectedCidade;

    Widget buildFieldId()
    {
        return SizedBox
        (
            width: 100,
            height: 45,
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
            height: 45,
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

    Widget buildFieldEmail()
    {
        return SizedBox
        (
            width: 300,
            height: 45,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text
                    (
                        'E-mail'
                    ),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    email = newValue;
                }
            ),
        );
    }

    Widget buildFieldCep()
    {
        return SizedBox
        (
            width: 300,
            height: 45,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text
                    (
                        'CEP'
                    ),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    cep = newValue;
                }
            ),
        );
    }

    Widget buildFieldBairro()
    {
        return SizedBox
        (
            width: 300,
            height: 45,
            child: TextFormField
            (
                decoration: const InputDecoration
                (
                    label: Text
                    (
                        'Bairro'
                    ),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    return null;
                },
                onSaved: (newValue)
                {
                    bairro = newValue;
                }
            ),
        );
    }
 
    DropdownButtonFormField buildComboTipoPessoa()
    {
        var items = [
            const DropdownMenuItem
            (
                value: 0,
                child: Text('Selecione um tipo de pessoa')
            ),
            const DropdownMenuItem
            (
                value: 1,
                child: Text('Pessoa Física')
            ),
            const DropdownMenuItem
            (
                value: 2,
                child: Text('Pessoa Jurídica')
            )
        ];

        return DropdownButtonFormField
        (
            isExpanded: true,
            value: 0,
            hint: const Text('Selecione um tipo!'),
            items: items,
            onChanged: (value) => setState(()
            {
                selectedTipoPessoa = value;
            }),
            validator: (value)
            {
                if(value == null)
                {
                    return 'Selecione um tipo!';
                }
                return null;
            },
            onSaved: (value)
            {
                selectedTipoPessoa = value;
            },
        );
    }

    FutureBuilder buildComboCidade()
    {
        return FutureBuilder<List<dynamic>>
        (
            future: allCidades,
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
                            child: Text('Selecione uma cidade')
                        )
                    );

                    return DropdownButtonFormField
                    (
                        isExpanded: true,
                        value: 0,
                        hint: const Text('Selecione uma cidade'),
                        items: list,
                        onChanged: (value) => setState(()
                        {
                            selectedCidade = value!;
                        }),
                        validator: (value)
                        {
                            if(value == null)
                            {
                                return 'Selecione uma cidade!';
                            }
                            return null;
                        },
                        onSaved: (value)
                        {
                            selectedCidade = value;
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
                title: const Text('Pessoas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                backgroundColor: Colors.greenAccent,
            ),
            body: 
            Wrap
            (
                children:
                [
                    const Padding(padding: EdgeInsets.all(10)),
                    Form
                    (
                        key: formKey,
                        child:
                        Container
                        (
                            height: 190,
                            child: 
                            Flex
                            (
                                direction: Axis.vertical,
                                mainAxisSize: MainAxisSize.min,
                                children:
                                [
                                    Flexible
                                    (
                                        child:
                                        Row
                                        (
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>
                                            [
                                                const SizedBox(width: 250),
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
                                                    flex: 3,
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
                                                    flex: 3,
                                                    child: Column
                                                    (
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children:
                                                        [
                                                            buildComboTipoPessoa()
                                                        ]
                                                    )
                                                ),
                                            ],
                                        ),
                                    ),    
                                    Flexible
                                    (
                                        child:
                                        Row
                                        (
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>
                                            [
                                                const SizedBox(width: 250),
                                                Flexible
                                                (
                                                    flex: 3,
                                                    child: Column
                                                    (
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children:
                                                        [
                                                            buildFieldEmail()
                                                        ]
                                                    )
                                                ),
                                                const Flexible
                                                (
                                                    child:  Padding(padding: EdgeInsets.all(5),)
                                                ),
                                                Flexible
                                                (
                                                    flex: 1,
                                                    child: Column
                                                    (
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children:
                                                        [
                                                            buildFieldCep()
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
                                                    child: Column
                                                    (
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children:
                                                        [
                                                            buildFieldBairro()
                                                        ]
                                                    )
                                                ),
                                                const Flexible
                                                (
                                                    child: Padding(padding: EdgeInsets.all(5),)
                                                ),
                                                Flexible
                                                (
                                                    flex: 3,
                                                    child: Column
                                                    (
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children:
                                                        [
                                                            buildComboCidade()
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
                                            ],
                                        )
                                    ),
                                    Flexible
                                    (
                                        child:
                                        Row
                                        (
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:
                                            [
                                                Flexible
                                                (
                                                    flex: 1,
                                                    child:
                                                    Column
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
                                                                    * filtrar Pessoa
                                                                    */
                                                                    int? id = this.id != null && this.id != '' ? int.parse(this.id!) : 0;
                                                                    Pessoa pessoa = Pessoa
                                                                    (
                                                                        nome ?? '',
                                                                        email ?? '',
                                                                        '', // senha
                                                                        '', // telefone
                                                                        cep ?? '',
                                                                        '', // rua
                                                                        bairro ?? '',
                                                                        0,  // numeroEndereco
                                                                        selectedCidade == null ? 0 : selectedCidade as int,  // cidade
                                                                        '', // complemento
                                                                        selectedTipoPessoa == null ? 0 : selectedTipoPessoa as int,
                                                                        id
                                                                    );

                                                                    setState(()
                                                                    {
                                                                        filteredList = PessoaController().getFiltered(pessoa);
                                                                    });
                                                                },
                                                            ),
                                                        ]
                                                    )
                                                ),
                                                const SizedBox(width: 10),
                                                Flexible
                                                (
                                                    flex: 1,
                                                    child: 
                                                    Column
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
                                                                    'Cadastrar',
                                                                    style: TextStyle(color: Colors.white),
                                                                ),
                                                                onPressed: ()
                                                                {
                                                                    Navigator.of(context).push
                                                                    (
                                                                        MaterialPageRoute
                                                                        (
                                                                            builder: (context) => const PessoaView( null ),
                                                                        ),
                                                                    );
                                                                },
                                                            ),
                                                        ]
                                                    ),
                                                ),
                                                const SizedBox(width: 390)
                                            ],
                                        )
                                    )
                                ],
                            )
                        )
                    ),
                    SingleChildScrollView
                    (
                        scrollDirection: Axis.vertical,
                        child:
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
                                            width: MediaQuery.of(context).size.width/1.30,
                                            child:
                                            PaginatedDataTable
                                            (
                                                columnSpacing: 0.01,
                                                columns: const
                                                [
                                                    DataColumn(label: Text('Código')),
                                                    DataColumn(label: Text('Nome')),
                                                    DataColumn(label: Text('E-mail')),
                                                    DataColumn(label: Text('CEP')),
                                                    DataColumn(label: Text('Bairro')),
                                                    DataColumn(label: Text('Cidade')),
                                                    DataColumn(label: Text('Tipo')),
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
                    )
                ]
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
                DataCell(Text(rows[index].id.toString())),
                DataCell(Text(rows[index].nome)),
                DataCell(Text(rows[index].email)),
                DataCell(Text(rows[index].cep)),
                DataCell(Text(rows[index].bairro)),
                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: buildCellCidade(rows[index].cidade)
                    )
                ),
                DataCell
                (
                    Padding
                    (
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: buidlCellTipoPessoa(rows[index].id)
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
                                var id = rows[index].id;

                                Navigator.of(context).push
                                (
                                    MaterialPageRoute
                                    (
                                        builder: (context) => PessoaView(id),
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
                                var id = rows[index].id;

                                showDialog
                                (
                                    context: context,
                                    builder: (context) => AlertDialog
                                    (
                                        title: const Text('Alerta!'),
                                        content: const Text('Deseja desativar esta pessoa?'),
                                        actions:
                                        [
                                            ElevatedButton
                                            (
                                                onPressed: ()
                                                {
                                                    PessoaController().delete(Pessoa.byId(id));
                                                    Navigator.of(context).push
                                                    (
                                                        MaterialPageRoute
                                                        (
                                                            builder: (context) => const PessoaListView()
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

    FutureBuilder buidlCellTipoPessoa(int id)
    {
        return FutureBuilder<Pessoa>
        (
            future: PessoaController().get(Pessoa.byId(id)),
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
                    var data = snapshot.data!;
                    return Text(data.tipoPessoa == 1 ? 'Física' : 'Jurídica');
                }
                else
                {
                    return const Text('');
                }
            },
        );
    }

    FutureBuilder buildCellCidade(int id)
    {
        return FutureBuilder<Cidade>
        (
            future: CidadeController().get(Cidade.byId(id)),
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
                    var data = snapshot.data!;
                    return Text(data.nome);
                }
                else
                {
                    return const Text('');
                }
            },
        );
    }
}