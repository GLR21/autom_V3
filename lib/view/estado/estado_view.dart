import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/controllers/estado_controller.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
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

    String? sigla;
    String? nome;
    String? codIbge;

    Widget buildFieldSigla()
    {
        return SizedBox
        (
            width: 100,
            child: TextFormField
            (
                decoration: const InputDecoration(label: Text('Sigla')),
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

    Widget buildFieldNome()
    {
        return SizedBox
        (
            width: 300,
            child: TextFormField
            (
                decoration: const InputDecoration(label: Text('Nome')),
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

    Widget buildFieldCodIbge()
    {
        return SizedBox
        (
            width: 136,
            child: TextFormField
            (
                decoration: const InputDecoration(label: Text('Código IBGE')),
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
        Scaffold scaffold = Scaffold
        (
            appBar: AppBar
            (
                title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
                            child: Form
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
                                                    buildFieldSigla(),
                                                    buildFieldNome(),
                                                    buildFieldCodIbge()
                                                ],                                            
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(32),
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
                                                        child: const Text
                                                        (
                                                            'Inserir',
                                                            style: TextStyle(color: Colors.green),
                                                        ),
                                                        onPressed: ()
                                                        {
                                                            if(!formKey.currentState!.validate())
                                                            {
                                                                return;
                                                            }
                                            
                                                            formKey.currentState!.save();

                                                            Estado estado = Estado(nome!, sigla!, int.parse(codIbge!));
                                                            EstadoController().insert(estado);

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
                            ),
                        ),
                    ]
                )
            )
        );

        return scaffold;
    }
}