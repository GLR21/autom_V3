import 'package:autom_v3/database/connection.dart';
import 'package:autom_v3/models/model_interface.dart';

class Model<T>
    implements ModelInterface<T>
{
    String tableName = '';
    String primaryKey = 'id';

    Future<Object> _query(String query) async
    {
        var connection = Connection.getInstance();
        try
        {
            await connection.open();
            var result = await connection?.query(query);
            await connection.close();
            return result;
        }
        catch ( e )
        {
            await connection.close();
            print( 'Exception details:\n $e \n\n Exception ' );
            return [];
        }   
    }

    @override
    Future<Object> insert ( Map< String, T > object ) async
    {
        String query = "INSERT INTO $tableName (";

        // Remove primary key from object to avoid errors on insert
        object.remove(primaryKey);

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
        var result = await _query(query);
        return result;
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

        var result = await _query(query);
        return result;
    }

    @override
    Future<Object> delete ( Map< String, T > object ) async
    {
        String query = "DELETE FROM $tableName WHERE $primaryKey = ${object[primaryKey]} RETURNING *;";

        var result = await _query(query);
        return result;
    }

    @override
    Future<Object> select ( Map< String, T > object ) async
    {
        String query = "SELECT * FROM $tableName WHERE $primaryKey = ${object[primaryKey]};";

        var result = await _query(query);
        return result;
    }

    Future<Object> selectAll () async
    {
        String query = "SELECT * FROM $tableName;";

        var result = await _query(query);
        return result;
    }
}