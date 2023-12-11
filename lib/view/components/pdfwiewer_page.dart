import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:pdfx/pdfx.dart';

import 'package:autom_v3/view/report/reports_pedidos_generate.dart';

class PDFViewerPage extends StatefulWidget
{
    final String path;

    const PDFViewerPage({Key key = const Key('report-key'), required this.path}) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage>
{
    @override
    Widget build(BuildContext context)
    {
        File file = File(widget.path);

        ReportPedidosGenerate reportPedido = ReportPedidosGenerate();
        
        final pdfController = PdfController
        (
            document: PdfDocument.openData(reportPedido.buildReportToByes())
            // document: PdfDocument.openFile(widget.path),
        );

        return Scaffold
        (
            appBar: AppBar
            (
                title: const Text('Relatório'),
            ),
            body: PdfView
            (
                controller: pdfController,
            )
        );
    }
}