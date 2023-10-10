import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/classes/marca.dart';
import 'package:autom_v3/controllers/estado_controller.dart';
import 'package:autom_v3/controllers/marca_controller.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:autom_v3/view/estado/estado_list_view.dart';
import 'package:autom_v3/view/marca/marca_list_view.dart';
import 'package:flutter/material.dart';

class MarcaView extends StatefulWidget
{
    final int? id;

    const MarcaView(this.id, {super.key});

    @override
    State<StatefulWidget> createState() => _MarcaView();
}

class _MarcaView extends State<MarcaView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<Marca> marca = Future.value(Marca.empty());

    String? id;
    String? nome;

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
            marca = MarcaController().get(Marca.byId(id));
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
                                    future: marca,
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
                                            var marca =  snapshot.data!;

                                            return Form
                                            (
                                                key: formKey,
                                                child: Column
                                                (
                                                    
                                                    children: <Widget>
                                                    [
                                                        (
                                                            isEdit ? Row
                                                            (
                                                                children:
                                                                [
                                                                    Expanded
                                                                    (
                                                                        flex: 1,
                                                                        child: ListTile
                                                                        (
                                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                            subtitle: buildFieldId(marca.id.toString())
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
                                                                            subtitle: buildFieldNome( marca.nome ),
                                                                        ) 
                                                                    )
                                                                ],
                                                            )
                                                            :
                                                            ListTile
                                                            (
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                title: buildFieldNome( marca.nome ),
                                                            )
                                                        ),
                                                        const SizedBox
                                                        (
                                                            height: 2
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

                                                                                    Marca marca = Marca(nome!);
                                                                                    MarcaController().insert(marca);

                                                                                    DialogBuilder().showInfoDialog
                                                                                    (
                                                                                        'Sucesso',
                                                                                        'Marca inserida com sucesso',
                                                                                        context
                                                                                    ).then((value) =>
                                                                                        Navigator.of(context).push
                                                                                        (
                                                                                            MaterialPageRoute
                                                                                            (
                                                                                                builder: (context) => const MarcaListView()
                                                                                            ),
                                                                                        )
                                                                                    );
                                                                                }
                                                                                else
                                                                                {
                                                                                    /* Atualizar */
                                                                                    formKey.currentState!.save();

                                                                                    Marca marca = Marca(nome!, id!);
                                                                                    MarcaController().update(marca);

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
                                                                                                builder: (context) => const MarcaListView()
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