import 'package:autom_v3/database/connection.dart';
import 'package:autom_v3/models/model_interface.dart';

class Model<T>
    implements ModelInterface<T>
{
    String tableName = '';
    String primaryKey = 'id';

    Future<Object> _query(String query) async
    {
        try
        {
            var connection = Connection.getInstance();
            await connection.open();
            var result = await connection?.query(query);
            await connection.close();
            return result;
        }
        catch (e)
        {
            return [];
        }   
    }

    @override
    Future<Object> insert ( Map< String, T > object ) async
    {
        String query = "INSERT INTO $tableName (";
        object.forEach((key, value) {
            query += "$key,";
        });

        query = query.substring(0, query.length - 1);

        query += ") VALUES (";

        object.forEach((key, value) {
            query += "'$value',";
        });

        query = query.substring(0, query.length - 1);

        query += ") RETURNING *;";

        try
        {
            var result = await _query(query);
            return result;
        }
        catch (e)
        {
            return [];
        }
    }

    @override
    Future<Object> update ( Map< String,  T  > object ) async
    {
        String query = "UPDATE $tableName SET ";
        object.forEach((key, value) {
            query += "$key = '$value',";
        });

        query = query.substring(0, query.length - 1);

        query += " WHERE $primaryKey = ${object[primaryKey]} RETURNING *;";

        try
        {
            var result = await _query(query);
            return result;
        }
        catch (e)
        {
            return [];
        }
    }

    @override
    Future<Object> delete ( Map< String, T > object ) async
    {
        String query = "DELETE FROM $tableName WHERE $primaryKey = ${object[primaryKey]} RETURNING *;";

        try
        {
            var result = await _query(query);
            return result;
        }
        catch (e)
        {
            return [];
        }
    }

    @override
    Future<Object> select ( Map< String, T > object ) async
    {
        String query = "SELECT * FROM $tableName WHERE $primaryKey = ${object[primaryKey]};";

        try
        {
            var result = await _query(query);
            return result;
        }
        catch (e)
        {
            return [];
        }
    }

    Future<Object> selectAll () async
    {
        String query = "SELECT * FROM $tableName;";

        try
        {
            var result = await _query(query);
            return result;
        }
        catch (e)
        {
            return [];
        }
    }
}