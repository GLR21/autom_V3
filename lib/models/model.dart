import 'package:autom_v3/database/connection.dart';
import 'package:autom_v3/models/model_interface.dart';

class Model<T>
    implements ModelInterface<T>
{
    String tableName = '';
    String primaryKey = 'id';

    Future<dynamic> _query(String query) async
    {
        var connection = Connection.getInstance();
        try
        {
            await connection.open();
            var result = await connection?.mappedResultsQuery(query);
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

    List _getReturnLines ( dynamic result )
    {
        List resultArray = List.empty(growable: true);
        result.forEach((element) {
            resultArray.add(element[tableName]);
        });
        return resultArray;
    }

    @override
    Future<dynamic> insert ( Map< String, T > object ) async
    {
        String query = "INSERT INTO $tableName (";

        // Remove primary key from object to avoid errors on insert
        if( object.containsKey(primaryKey) && primaryKey == 'id' )
        {
            object.remove(primaryKey);
        }

        object.forEach((key, value)
        {
            query += "$key,";
        });

        query = query.substring(0, query.length - 1);

        query += ") VALUES (";

        object.forEach((key, value)
        {
            if(key.startsWith('ref_'))
            {
                query += "$value,";    
            }
            else
            {
                query += "'$value',";    
            }
        });

        query = query.substring(0, query.length - 1);

        query += ") RETURNING *;";
        var result = await _query(query);
        return _getReturnLines(result);
    }

    @override
    Future<dynamic> update ( Map< String,  T  > object ) async
    {
        String query = "UPDATE $tableName SET ";
        object.forEach((key, value) {
            query += "$key = '$value',";
        });

        query = query.substring(0, query.length - 1);

        query += " WHERE $primaryKey = ${object[primaryKey]} RETURNING *;";

        var result = await _query(query);
        return _getReturnLines(result);
    }

    @override
    Future<dynamic> delete ( Map< String, T > object ) async
    {
        String query = "DELETE FROM $tableName WHERE $primaryKey = ${object[primaryKey]} RETURNING *;";

        var result = await _query(query);
        return _getReturnLines(result);
    }

    @override
    Future< dynamic > select ( Map< String, T > object ) async
    {
        String query = "SELECT * FROM $tableName WHERE $primaryKey = ${object[primaryKey]};";

        var result = await _query(query);
        return _getReturnLines(result);
    }

    Future< dynamic > selectAll () async
    {
        String query = "SELECT * FROM $tableName;";

        var result = await _query(query);
        return _getReturnLines(result);
    }

    Future< dynamic > manualQuery( String query ) async
    {
        var result = await _query(query);
        return _getReturnLines(result);
    }

    Future< dynamic > selectQueryBuilder ( Map< String, T > object ) async
    {
        const where_ =  'WHERE';

        int count = 0;

        String select = "SELECT * FROM $tableName ";
        String where = where_;
        object.forEach
        (
            (key, value)
            {
                if(value != '' && value != 0)
                {
                    count++;

                    if(count <= 1)
                    {
                        if(value is String)
                        {
                            where += " $key ILIKE '%$value%' ";
                        }
                        if(value is int || value is double)
                        {
                            where += " $key = $value ";
                        }
                    }
                    else
                    {
                        if(value is String)
                        {
                            where += "AND $key ILIKE '%$value%' ";
                        }
                        if(value is int || value is double)
                        {
                            where += "AND $key = $value ";
                        }
                    }
                }
            }
        );

        String query = "";
        if(where == where_)
        {
            query = select;
        }
        else
        {
            query = select + where;
        }

        var result = await _query(query);
        return _getReturnLines(result);
    }
}