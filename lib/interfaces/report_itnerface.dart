import 'dart:typed_data';

abstract class ReportInterface
{
    void buildReportToFile(String path);

    Future<Uint8List> buildReportToBytes(String path);
}