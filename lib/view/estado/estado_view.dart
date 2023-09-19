import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/controllers/estado_controller.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
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

    String? sigla;
    String? nome;
    String? codIbge;

    Widget buildFieldSigla(String text)
    {
        return SizedBox
        (
            width: 100,
            child: TextFormField
            (
                initialValue: text,
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
            ),
        );
    }

    Widget buildFieldNome(String text)
    {
        return SizedBox
        (
            width: 300,
            child: TextFormField
            (
                initialValue: text,
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
            ),
        );
    }

    Widget buildFieldCodIbge(String? text)
    {
        return SizedBox
        (
            width: 136,
            child: TextFormField
            (
                initialValue: text,
                decoration: const InputDecoration
                (
                    label: Text('Código IBGE'),
                    border: OutlineInputBorder()
                ),
                validator: (String? value)
                {
                    if(value!.isEmpty)
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
                body: Wrap
                (
                    children:
                    [
                        Container
                        (
                            margin: const EdgeInsets.all(0),
                            child: FutureBuilder
                            (
                                future: estado,
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
                                        var estado =  snapshot.data!;

                                        return Form
                                        (
                                            key: formKey,
                                            child: Column
                                            (
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>
                                                [
                                                    Padding
                                                    (
                                                        padding: const EdgeInsets.all(32),
                                                        child: Column
                                                        (
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children:
                                                            [
                                                                buildFieldSigla(estado.sigla),
                                                                const Padding
                                                                (
                                                                    padding: EdgeInsets.all(5)
                                                                ),
                                                                buildFieldNome(estado.nome),
                                                                const Padding
                                                                (
                                                                    padding: EdgeInsets.all(5)
                                                                ),
                                                                buildFieldCodIbge(estado.codIbge.toString())
                                                            ],                                            
                                                        ),
                                                    ),
                                                    Padding
                                                    (
                                                        padding: const EdgeInsets.symmetric(horizontal: 23),
                                                        child: Row
                                                        (
                                                            children:
                                                            [
                                                                const Padding
                                                                (
                                                                    padding: EdgeInsets.all(5)
                                                                ),
                                                                ElevatedButton
                                                                (
                                                                    child: Text
                                                                    (
                                                                        isEdit ? 'Atualizar' : 'Inserir',
                                                                        style: const TextStyle(color: Colors.green),
                                                                    ),
                                                                    onPressed: ()
                                                                    {
                                                                        if(!formKey.currentState!.validate())
                                                                        {
                                                                            return;
                                                                        }
                                                        
                                                                        if(!isEdit)
                                                                        {
                                                                            formKey.currentState!.save();

                                                                            Estado estado = Estado(nome!, sigla!, int.parse(codIbge!));
                                                                            EstadoController().insert(estado);
                                                                        }

                                                                        /*
                                                                        * mostrar mensagem
                                                                        */
                                                                        DialogBuilder().showInfoDialog
                                                                        (
                                                                            context,
                                                                            'Sucesso',
                                                                            'Estado inserido com sucesso'
                                                                        );

                                                                        /*
                                                                        * limpar formulário
                                                                        */
                                                                        formKey.currentState!.reset();
                                                                    },
                                                                ),
                                                            ],
                                                        ),
                                                    )
                                                ],
                                            )
                                        );
                                    }
                                },
                            ),
                            
                        ),
                    ]
                )
            )
        );

        return scaffold;
    }
}