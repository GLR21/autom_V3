import 'dart:io';
import 'dart:typed_data';

import 'package:autom_v3/interfaces/report_interface.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPedidosGenerate implements ReportInterface
{
    static const basefolder = 'files';

    @override
    void buildReportToFile(List items, String path) async
    {
        try
        {
            final file = File(path);
            await file.writeAsBytes(await buildReportToBytes(items, path));
        }
        catch(e)
        {
            print(e);
        }
    }

    @override
    Future<Uint8List> buildReportToBytes(List items, String path) async
    {
        final pdf = pw.Document();

        try
        {
            final headers = ['ID', 'Data Abertura', 'Data Encerramento', 'Quantidade', 'Total'];

            var data = <List<String>>[];
            items.forEach((element)
            {
                data.add
                (
                    [
                        element.id.toString(),
                        element.dtAbertura.toString().split(' ')[0],
                        element.dtEncerramento.toString().split(' ')[0],
                        element.pecasPedido.length.toString(),
                        element.total.toString(),
                    ]
                );
            });

            pw.Table table = pw.TableHelper.fromTextArray
            (
                context: null,
                headers: headers,
                data: data
            );

            pdf.addPage
            (
                pw.Page
                (
                    pageFormat: PdfPageFormat.a4,
                    build:(context) => pw.Wrap
                    (
                        children:
                        [
                            pw.Row
                            (
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: 
                                [
                                    pw.Text
                                    (
                                        'Relatório de Pedidos por Cliente',
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle
                                        (
                                            fontSize: 23,
                                            fontWeight: pw.FontWeight.bold
                                        )
                                    )
                                ],
                            ),
                            pw.SizedBox
                            (
                                height: 50
                            )
                            ,
                            pw.Center
                            (
                                child: table
                            )
                        ],
                    )
                )
            );

        }
        catch(e)
        {
            print(e);
        }

        return await pdf.save();
    }
}