import 'dart:async';
import 'dart:io';

import 'package:autom_v3/interfaces/report_itnerface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pdfx/pdfx.dart';

class PDFViewerPage extends StatefulWidget
{
    final ReportInterface builder;

    const PDFViewerPage({Key key = const Key('report-key'), required this.builder}) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage>
{
    @override
    Widget build(BuildContext context)
    {
        final pdfController = PdfController
        (
            document: PdfDocument.openData(widget.builder.buildReportToByes()),
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
                scrollDirection: Axis.vertical,
            )
        );
    }
}