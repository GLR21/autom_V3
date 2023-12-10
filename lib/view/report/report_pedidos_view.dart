import 'package:autom_v3/view/report/reports_pedidos_generate.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:flutter/material.dart';

class ReportPedidosView extends StatefulWidget
{
    const ReportPedidosView({Key? key}): super(key: key);

    @override
    State<StatefulWidget> createState() => _ReportPedidosViewState();
}

class _ReportPedidosViewState extends State<ReportPedidosView>
{
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Future<List> filteredList = MarcaController().getAll();

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
                title: const Text('Relatório de Pedidos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
                                                            'Gerar',
                                                            style: TextStyle(color: Colors.white),
                                                        ),
                                                        onPressed: () async
                                                        {
                                                            if(!formKey.currentState!.validate())
                                                            {
                                                                return;
                                                            }

                                                            formKey.currentState!.save();

                                                            ReportPedidosGenerate reportPedido = ReportPedidosGenerate();
                                                            reportPedido.buildReport();

                                                            print(ReportPedidosGenerate.pathReport);
                                                        },
                                                    ),
                                                ],
                                            ),
                                        ),
                                        const Flexible
                                        (
                                            child: Padding(padding: EdgeInsets.all(5),)
                                        ),
                                    ],
                                ),
                            )
                        )
                    ]
                )
            )
        );

        return scaffold;
    }
}
