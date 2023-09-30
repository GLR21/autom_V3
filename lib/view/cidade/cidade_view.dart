import 'package:autom_v3/classes/cidade.dart';
import 'package:autom_v3/controllers/cidade_controller.dart';
import 'package:autom_v3/view/cidade/cidade_list_view.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:flutter/material.dart';

class CidadeView extends StatefulWidget
{
    final int? id;

    const CidadeView(this.id, {super.key});

    @override
    State<StatefulWidget> createState() => _EstadoView();
}

class _EstadoView extends State<CidadeView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<Cidade> cidade = Future.value(Cidade.empty());

    String? id;
    String? nome;
    String? codIbge;
    String? refEstado;

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

    Widget buildFieldCodIbge(String? value)
    {
        return SizedBox
        (
            width: 136,
            child: TextFormField
            (
                initialValue: value,
                decoration: const InputDecoration
                (
                    label: Text('Código IBGE'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    if(value!.isEmpty || value == '0')
                    {
                        return '"Código IBGE" é obrigatório';
                    }
                    return null;
                },
                onSaved: (newValue)
                {
                    codIbge = newValue;
                },
            ),
        );
    }

    Widget buildFieldEstado(String? value)
    {
        return SizedBox
        (
            width: 136,
            child: TextFormField
            (
                initialValue: value,
                decoration: const InputDecoration
                (
                    label: Text('Código Estado'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    if(value!.isEmpty || value == '0')
                    {
                        return '"Código do Estado" é obrigatório';
                    }
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
        /*
         * verificar contexto
         */
        bool isEdit = false;
        int? id = widget.id;
        if(id != null)
        {
            isEdit = true;
            cidade = CidadeController().get(Cidade.byId(id));
        }

        Scaffold scaffold = Scaffold
        (
            appBar: AppBar
            (
                title: const Text
                (
                    'Cidades',
                    style: TextStyle
                    (
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                ),
                backgroundColor: Colors.greenAccent,
            ),
            body: Scaffold
            (
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
                                    future: cidade,
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
                                            var cidade =  snapshot.data!;

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
                                                                            subtitle: buildFieldId(cidade.id.toString())
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
                                                                            subtitle: buildFieldNome( cidade.nome ),
                                                                        ) 
                                                                    )    
                                                                ],
                                                            )
                                                            :
                                                            ListTile
                                                            (
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                title: buildFieldNome( cidade.nome ),
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
                                                                        subtitle: buildFieldCodIbge( cidade.codIbge.toString() )
                                                                    ) 
                                                                ),

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
                                                                        subtitle: buildFieldEstado( cidade.refEstado.toString() )
                                                                    ) 
                                                                ),  
                                                            ],
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
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
                                                                                    /* Inserir */
                                                                                    formKey.currentState!.save();

                                                                                    Cidade cidade = Cidade(nome!, codIbge!, int.parse(refEstado!));
                                                                                    CidadeController().insert(cidade);

                                                                                    DialogBuilder().showInfoDialog
                                                                                    (
                                                                                        'Sucesso',
                                                                                        'Cidade inserida com sucesso',
                                                                                        context
                                                                                    ).then((value) =>
                                                                                        Navigator.of(context).push
                                                                                        (
                                                                                            MaterialPageRoute
                                                                                            (
                                                                                                builder: (context) => const CidadeListView()
                                                                                            ),
                                                                                        )
                                                                                    );
                                                                                }
                                                                                else
                                                                                {
                                                                                    /* Atualizar  */
                                                                                    formKey.currentState!.save();

                                                                                    Cidade cidade = Cidade(nome!, codIbge!, int.parse(refEstado!));
                                                                                    CidadeController().insert(cidade);

                                                                                    DialogBuilder().showInfoDialog
                                                                                    (
                                                                                        'Sucesso',
                                                                                        'Cidade atualizada com sucesso',
                                                                                        context
                                                                                    ).then((value) =>
                                                                                        Navigator.of(context).push
                                                                                        (
                                                                                            MaterialPageRoute
                                                                                            (
                                                                                                builder: (context) => const CidadeListView()
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
            )
        );

        return scaffold;
    }
}