// ignore_for_file: unused_import, unused_local_variable

// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() async
{
    await dotenv.load(fileName: ".env");

    try
    {
        final pdf = pw.Document();

        /// Criar tabela
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
            data: data
        );

        pdf.addPage
        (
            pw.Page
            (
                pageFormat: PdfPageFormat.a4,
                build:(context) => pw.Center
                (
                    child: pw.Wrap
                    (
                        children:
                        [
                            pw.Row
                            (
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
                            pw.Row
                            (
                                children:
                                [
                                    table
                                ]
                            )
                        ]
                    )
                )
            )
        );

        final file = File('files/test.pdf');
        await file.writeAsBytes(await pdf.save());
    }
    catch(e)
    {
        print(e);
    }
}
