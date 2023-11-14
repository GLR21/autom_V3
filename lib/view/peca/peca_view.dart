import 'package:autom_v3/classes/peca.dart';
import 'package:autom_v3/controllers/marca_controller.dart';
import 'package:autom_v3/controllers/peca_controller.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:autom_v3/view/peca/peca_list_view.dart';
import 'package:flutter/material.dart';

class PecaView extends StatefulWidget
{
    final int? id;

    const PecaView(this.id, {super.key});

    @override
    State<StatefulWidget> createState() => _PecaView();
}

class _PecaView extends State<PecaView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<List<dynamic>> allMarcas = MarcaController().getAll();
    Future<Peca> peca = Future.value(Peca.empty());

    String? id;
    String? nome;
    String? descricao;
    String? valorCompra;
    String? valorRevenda;
    String? refMarca;

    Object? selectedMarca;

    Widget buildFieldId(String? value)
    {
        return Visibility
        (
            visible: int.parse(value!) != 0 ? true : false,
            child: TextFormField
            (
                initialValue: value,
                enabled: false,
                decoration: const InputDecoration
                (
                    label: Text('Código'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    if(value!.isEmpty)
                    {
                        return '"Código" é obrigatório';
                    }
                    return null;
                },
                onSaved: (newValue)
                {
                    id = newValue;
                },
            )
        );
    }

    Widget buildFieldNome(String value)
    {
        return TextFormField
        (
            initialValue: value,
            decoration: const InputDecoration
            (
                label: Text('Nome'),
                border: OutlineInputBorder()
            ),
            validator: (String? value)
            {
                if(value!.isEmpty)
                {
                    return '"Nome" é obrigatório';
                }
                return null;
            },
            onSaved: (newValue)
            {
                nome = newValue;
            },
        );
    }

    Widget buildFieldDescricao(String value)
    {
        return TextFormField
        (
            initialValue: value,
            decoration: const InputDecoration
            (
                label: Text('Descrição'),
                border: OutlineInputBorder()
            ),
            validator: (String? value)
            {
                if(value!.isEmpty)
                {
                    return '"Descrição" é obrigatória';
                }
                return null;
            },
            onSaved: (newValue)
            {
                descricao = newValue;
            },
        );
    }

    Widget buildFieldPrecoCompra(String value)
    {
        return TextFormField
        (
            keyboardType: TextInputType.number,
            initialValue: value,
            decoration: const InputDecoration
            (
                label: Text('Preço de compra'),
                border: OutlineInputBorder()
            ),
            validator: (String? value)
            {
                if(value!.isEmpty)
                {
                    return '"Preço de compra" é obrigatório';
                }
                return null;
            },
            onSaved: (newValue)
            {
                valorCompra = newValue;
            },
        );
    }

    Widget buildFieldPrecorRevenda(String value)
    {
        return TextFormField
        (
            keyboardType: TextInputType.number,
            initialValue: value,
            decoration: const InputDecoration
            (
                label: Text('Preço de revenda'),
                border: OutlineInputBorder()
            ),
            validator: (String? value)
            {
                if(value!.isEmpty)
                {
                    return '"Preço de revenda" é obrigatório';
                }
                return null;
            },
            onSaved: (newValue)
            {
                valorRevenda = newValue;
            },
        );
    }

    FutureBuilder buildComboMarca(int? selectedItem)
    {
        return FutureBuilder<List<dynamic>>
        (
            future: allMarcas,
            builder: (context, snapshot)
            {
                if( snapshot.connectionState == ConnectionState.waiting )
                {
                    return const Center
                    (
                        child: CircularProgressIndicator()
                    );
                }

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

                    return DropdownButtonFormField
                    (
                        value: selectedMarca != 0 ? selectedMarca : null,
                        isExpanded: true,
                        hint: const Text('Selecione uma marca'),
                        items: list,
                        onChanged: (value) => setState(()
                        {
                            selectedMarca = value!;
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
        /*
         * verificar contexto
         */
        bool isEdit = false;
        int? id = widget.id;
        if(id != null)
        {
            isEdit = true;
            peca = PecaController().get(Peca.byId(id));
        }

        Scaffold scaffold = Scaffold
        (
            appBar: AppBar
            (
                title: const Text
                (
                    'Peças',
                    style: TextStyle
                    (
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                ),
                backgroundColor: Colors.greenAccent,
            ),
            body: SingleChildScrollView
            (
                child:
                Padding
                (
                    padding: const EdgeInsets.all(10),

                    child:
                    
                    Center
                    (
                        child:
                        Container
                        (
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: FutureBuilder
                            (
                                future: peca,
                                builder: (context, snapshot)
                                {
                                    if( snapshot.connectionState == ConnectionState.waiting )
                                    {
                                        return const Center
                                        (
                                            child: CircularProgressIndicator()
                                        );
                                    }

                                    if(snapshot.hasError)
                                    {
                                        return Text('Error: ${snapshot.error}');
                                    }
                                    else
                                    {
                                        var peca =  snapshot.data!;
                                        /**
                                         * Ao editar precisa pegar dados vindos da tela de listagem
                                         */
                                        selectedMarca ??= snapshot.data!.refMarca;

                                        return
                                        Form
                                        (
                                            key: formKey,
                                            child: Column
                                            (
                                                children: <Widget>
                                                [
                                                    (
                                                        isEdit ?
                                                        Row
                                                        (
                                                            children:
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldId(peca.id.toString())
                                                                    ) 
                                                                ),

                                                                const SizedBox
                                                                (
                                                                    width: 1
                                                                ),

                                                                Expanded
                                                                (
                                                                    flex: 5,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldNome(peca.nome),
                                                                    ) 
                                                                )
                                                            ],
                                                        )
                                                        :
                                                        ListTile
                                                        (
                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                            title: buildFieldNome(peca.nome),
                                                        )
                                                    ),
                                                    
                                                    const SizedBox
                                                    (
                                                        height: 2
                                                    ),
                                                    
                                                    Row
                                                    (
                                                        children:
                                                        [
                                                            const SizedBox
                                                            (
                                                                width: 2
                                                            ),

                                                            Expanded
                                                            (
                                                                flex: 1,
                                                                child: ListTile
                                                                (
                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                    subtitle: buildFieldDescricao(peca.descricao)
                                                                ) 
                                                            ),

                                                            const SizedBox
                                                            (
                                                                width: 2
                                                            ),

                                                            Expanded
                                                            (
                                                                flex: 1,
                                                                child:
                                                                ListTile
                                                                (
                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                    subtitle: buildComboMarca(peca.refMarca)
                                                                ) 
                                                            ),  
                                                        ],
                                                    ),

                                                    const SizedBox
                                                    (
                                                        height: 5
                                                    ),

                                                    const SizedBox
                                                    (
                                                        height: 5
                                                    ),

                                                    Row
                                                    (
                                                        children:
                                                        [
                                                            const SizedBox
                                                            (
                                                                width: 2
                                                            ),

                                                            Expanded
                                                            (
                                                                flex: 1,
                                                                child:
                                                                ListTile
                                                                (
                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                    subtitle: buildFieldPrecoCompra(peca.valorCompra.toString())
                                                                )
                                                            ),

                                                            const SizedBox
                                                            (
                                                                width: 2
                                                            ),

                                                            Expanded
                                                            (
                                                                flex: 1,
                                                                child:
                                                                ListTile
                                                                (
                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                    subtitle: buildFieldPrecorRevenda(peca.valorRevenda.toString())
                                                                )
                                                            ),
                                                        ],
                                                    ),

                                                    Row
                                                    (
                                                        children:
                                                        [
                                                            Expanded
                                                            (
                                                                flex: 1,
                                                                child: 
                                                                ListTile
                                                                (
                                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                    title: 
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
                                                                        child: Text
                                                                        (
                                                                            isEdit ? 'Atualizar' : 'Salvar',
                                                                            style: const TextStyle(color: Colors.white),
                                                                        ),
                                                                        onPressed: ()
                                                                        {
                                                                            if(!formKey.currentState!.validate())
                                                                            {
                                                                                return;
                                                                            }

                                                                            if(!isEdit)
                                                                            {
                                                                                int marca = int.parse(selectedMarca.toString());
                                                                                /* Inserir */
                                                                                formKey.currentState!.save();

                                                                                Peca peca = Peca
                                                                                    (
                                                                                        nome!,
                                                                                        descricao!,
                                                                                        num.parse(valorCompra!),
                                                                                        num.parse(valorRevenda!),
                                                                                        marca
                                                                                    );
                                                                                PecaController().insert(peca);

                                                                                DialogBuilder().showInfoDialog
                                                                                (
                                                                                    'Sucesso',
                                                                                    'Peça inserida com sucesso',
                                                                                    context
                                                                                ).then((value) =>
                                                                                    Navigator.of(context).push
                                                                                    (
                                                                                        MaterialPageRoute
                                                                                        (
                                                                                            builder: (context) => const PecaListView()
                                                                                        ),
                                                                                    )
                                                                                );
                                                                            }
                                                                            else
                                                                            {
                                                                                int marca = int.parse(selectedMarca.toString());

                                                                                /* Atualizar  */
                                                                                formKey.currentState!.save();

                                                                                Peca peca = Peca
                                                                                    (
                                                                                        nome!,
                                                                                        descricao!,
                                                                                        0.00,
                                                                                        0.00,
                                                                                        marca,
                                                                                        id!
                                                                                    );
                                                                                PecaController().update(peca);

                                                                                DialogBuilder().showInfoDialog
                                                                                (
                                                                                    'Sucesso',
                                                                                    'Peça atualizada com sucesso',
                                                                                    context
                                                                                ).then((value) =>
                                                                                    Navigator.of(context).push
                                                                                    (
                                                                                        MaterialPageRoute
                                                                                        (
                                                                                            builder: (context) => const PecaListView()
                                                                                        ),
                                                                                    )
                                                                                );

                                                                                /* Limpar form */
                                                                                formKey.currentState!.reset();
                                                                            }
                                                                        },
                                                                    )
                                                                )
                                                            )
                                                        ],
                                                    )
                                                ],
                                            )
                                        );
                                    }
                                },
                            ),
                        
                        )
                    )
                )
            )
        );

        return scaffold;
    }
}