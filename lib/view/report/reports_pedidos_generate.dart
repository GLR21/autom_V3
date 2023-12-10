import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPedidosGenerate
{
    static const pathReport = 'files/relatorio-pedido.pdf';

    void buildReport() async
    {
        try
        {
            final pdf = pw.Document();

            final headers = ['Item', 'Price', 'Quantity'];
            final data = <List<String>>
                [
                    ['Item 1', '200', '1'],
                    ['Item 2', '150', '2'],
                    ['Item 3', '100', '3'],
                    ['Item 4', '75' , '4'],
                ];

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

            final file = File(pathReport);
            await file.writeAsBytes(await pdf.save());
        }
        catch(e)
        {
            print(e);
        }
    }
}