import 'package:autom_v3/database/connection.dart';

class Model
{
    Future<Object> query(String query) async
    {
        var connection = Connection.getInstance();
        await connection.open();
        var result = await connection?.query(query);
        await connection.close();
        return result;
    }
}