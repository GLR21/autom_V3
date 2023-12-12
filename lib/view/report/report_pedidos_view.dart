import 'package:autom_v3/classes/pedido.dart';
import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/controllers/pedido_controller.dart';
import 'package:autom_v3/controllers/pessoa_controller.dart';
import 'package:autom_v3/utils/datetime_utils.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:autom_v3/view/report/reports_pedidos_generate.dart';
import 'package:flutter/material.dart';

import 'dart:io';

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

    Future<List<dynamic>> allPessoas = PessoaController().getAll();

    String? id;
    String? nome;

    Object? selectedPessoa;
    Object? selectedStatusPedido;

    DropdownButtonFormField buildComboStatusPedido()
    {
        var items = [
            const DropdownMenuItem
            (
                value: 0,
                child: Text('Status do pedido')
            ),
            const DropdownMenuItem
            (
                value: 1,
                child: Text('Cancelado')
            ),
            const DropdownMenuItem
            (
                value: 2,
                child: Text('Pendente')
            ),
            const DropdownMenuItem
            (
                value: 3,
                child: Text('Concluído')
            )
        ];

        return DropdownButtonFormField
        (
            isExpanded: true,
            value: 0,
            hint: const Text('Selecione um status!'),
            items: items,
            onChanged: (value) => setState(()
            {
                selectedStatusPedido = value;
            }),
            validator: (value)
            {
                if(value == null)
                {
                    return 'Selecione um status!';
                }
                return null;
            },
            onSaved: (value)
            {
                selectedStatusPedido = value;
            },
        );
    }

    FutureBuilder buildComboPessoa()
    {
        return FutureBuilder<List<dynamic>>
        (
            future: allPessoas,
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
                            value: map.id,
                            child: Text(map.nome)
                        )
                    );
                    var list = map.toList();
                    list.insert
                    (
                        0,
                        const DropdownMenuItem
                        (
                            value: 0,
                            child: Text('Selecione uma pessoa')
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
                            selectedPessoa = value!;
                        }),
                        validator: (value)
                        {
                            if(value == null)
                            {
                                return 'Selecione uma pessoa!';
                            }
                            return null;
                        },
                        onSaved: (value)
                        {
                            selectedPessoa = value;
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
                                                    buildComboPessoa()
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
                                                    buildComboStatusPedido()
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

                                                            /**
                                                             * Buscar pedidos da pessoa
                                                             */
                                                            List<Pedido> pedidosFiltered = [];

                                                            var pedidos = await PedidoController().getAllPedidos();
                                                            pedidos.forEach
                                                            (
                                                                (pedido) =>
                                                                {
                                                                    if(
                                                                       pedido.refCliente?.id == int.parse(selectedPessoa.toString())
                                                                    && pedido.status == selectedStatusPedido
                                                                    )
                                                                    {
                                                                        pedidosFiltered.add(pedido)
                                                                    }
                                                                }
                                                            );

                                                            String caminho = "${ReportPedidosGenerate.basefolder}/relatorio_pedidos_${DateTimeUtils.nowTimeForFilenameAsIso8601()}.pdf";
                                                            ReportPedidosGenerate reportPedido = ReportPedidosGenerate();
                                                            reportPedido.buildReportToFile
                                                            (
                                                                pedidosFiltered,
                                                                caminho
                                                            );

                                                            /**
                                                             * Mensagem de sucesso
                                                             */
                                                            showDialogSucesso(caminho, context);
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

    void showDialogSucesso(String caminho, context)
    {
        DialogBuilder().showInfoDialog
        (
            'Sucesso!',
            "Relatório gerado com sucesso! \n\n Caminho: $caminho",
            context
        );
    }
}
