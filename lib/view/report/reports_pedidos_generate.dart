import 'dart:io';
import 'dart:typed_data';

import 'package:autom_v3/interfaces/report_itnerface.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPedidosGenerate implements ReportInterface
{
    static const basefolder = 'files';

    @override
    void buildReportToFile(String path) async
    {
        try
        {
            final file = File(path);
            await file.writeAsBytes(await buildReportToBytes(path));
        }
        catch(e)
        {
            print(e);
        }
    }

    @override
    Future<Uint8List> buildReportToBytes(String path) async
    {
        final pdf = pw.Document();

        try
        {
         
            final headers = ['ID', 'Data Abertura', 'Data Encerramento', 'Quantidade', 'Total'];
            final data = <List<String>>
                [
                    ['13', '2023-01-01', '2023-01-13', '1', '221.00'],
                    ['17', '2023-01-01', '2023-01-17', '2', '442.00'],
                    ['23', '2023-01-01', '2023-01-23', '3', '663.00'],
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
                    pageFormat: PdfPageFormat.a5,
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