import 'dart:typed_data';

abstract class ReportInterface
{
    void buildReportToFile(List items, String path);

    Future<Uint8List> buildReportToBytes(List items, String path);
}