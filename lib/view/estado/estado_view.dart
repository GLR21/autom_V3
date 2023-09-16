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
        return TextFormField
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
        );
    }

    Widget buildFieldNome()
    {
        return TextFormField
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
        );
    }

    Widget buildFieldCodIbge()
    {
        return TextFormField
        (
            decoration: const InputDecoration(label: Text('Nome')),
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
        );
    }

    @override
    Widget build(BuildContext context)
    {

        // String id = .id.toString();

        Scaffold scaffold = Scaffold
        (
            appBar: AppBar
            (
                title: const Text('Estados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                backgroundColor: Colors.greenAccent,
            ),
            drawer: const NavigationPanel(),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>
                                    [
                                        Padding
                                        (
                                            padding: const EdgeInsets.all(32),
                                            child: Column
                                            (
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
                                        
                                                          print(nome);
                                                          print(sigla);
                                                          print(codIbge);
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
            // body: Center
            // (
            //     child: Text('Estado View: $id')
            // ),
        );

        return scaffold;
    }
}