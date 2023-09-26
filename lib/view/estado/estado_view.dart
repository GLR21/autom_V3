import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/controllers/estado_controller.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:autom_v3/view/estado/estado_list_view.dart';
import 'package:flutter/material.dart';

class EstadoView extends StatefulWidget
{
    final int? id;

    const EstadoView(this.id, {super.key});

    @override
    State<StatefulWidget> createState() => _EstadoView();
}

class _EstadoView extends State<EstadoView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<Estado> estado = Future.value(Estado.empty());

    String? id;
    String? sigla;
    String? nome;
    String? codIbge;

    Widget buildFieldId(String? value)
    {
        return Visibility
        (
            visible: int.parse(value!) != 0 ? true : false,
            // child: SizedBox
            // (
                // width: 100,
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
                        sigla = newValue;
                    },
                )
            // )
        );
    }

    Widget buildFieldSigla(String? value)
    {
        return TextFormField
        (
            initialValue: value,
            decoration: const InputDecoration
            (
                label: Text('Sigla'),
                border: OutlineInputBorder()
            ),
            validator: (String? value)
            {
                if(value!.isEmpty)
                {
                    return '"Sigla" é obrigatório';
                }
                return null;
            },
            onSaved: (newValue)
            {
                sigla = newValue;
            },
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
            estado = EstadoController().get(Estado.byId(id));
        }

        Scaffold scaffold = Scaffold
        (
            appBar: AppBar
            (
                title: const Text
                (
                    'Estados',
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
                                    future: estado,
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
                                            var estado =  snapshot.data!;

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
                                                                            subtitle: buildFieldId(estado.id.toString())
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
                                                                            subtitle: buildFieldNome( estado.nome ),
                                                                        ) 
                                                                    )    
                                                                ],
                                                            )
                                                            :
                                                            ListTile
                                                            (
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                title: buildFieldNome( estado.nome ),
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
                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldSigla(estado.sigla )
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
                                                                        subtitle: buildFieldCodIbge( estado.codIbge.toString() )
                                                                    ) 
                                                                )    
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

                                                                                    Estado estado = Estado(nome!, sigla!, int.parse(codIbge!));
                                                                                    EstadoController().insert(estado);

                                                                                    DialogBuilder().showInfoDialog
                                                                                    (
                                                                                        'Sucesso',
                                                                                        'Estado inserido com sucesso',
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
                                                                                }
                                                                                else
                                                                                {
                                                                                    /* Atualizar  */
                                                                                    formKey.currentState!.save();

                                                                                    Estado estado = Estado(nome!, sigla!, int.parse(codIbge!));
                                                                                    EstadoController().insert(estado);

                                                                                    DialogBuilder().showInfoDialog
                                                                                    (
                                                                                        'Sucesso',
                                                                                        'Estado atualizado com sucesso',
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