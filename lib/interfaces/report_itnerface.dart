import 'dart:typed_data';

abstract class ReportInterface
{
    void buildReportToFile();

    Future<Uint8List> buildReportToByes();
}