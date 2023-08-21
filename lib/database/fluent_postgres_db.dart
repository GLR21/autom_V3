import 'package:autom_v3/utils/environment_handler.dart';
import 'package:fluent_query_builder/fluent_query_builder.dart';

class FluentPostgresDB
{
    Future<DbLayer> _connect() async
    {
        return await DbLayer(_dbInfo()).connect();
    }

    DBConnectionInfo _dbInfo()
    {
        String database = EnvironmentHandler.get('POSTGRES_DATABASE_NAME');
        String username = EnvironmentHandler.get('POSTGRES_DATABASE_USERNAME');
        String password = EnvironmentHandler.get('POSTGRES_DATABASE_PASSWORD');
        String host = EnvironmentHandler.get('POSTGRES_DATABASE_HOST');
        String port = EnvironmentHandler.get('POSTGRES_DATABASE_PORT');
        String charset = EnvironmentHandler.get('POSTGRES_DATABASE_CHARSET');

        return DBConnectionInfo(
            host: host,
            database: database,
            driver: ConnectionDriver.pgsql,
            port: int.parse(port),
            username: username,
            password: password,
            charset: charset,
            schemes: ['public'],
        );
    }

    Future<DbLayer> getInstance()
    {
        final Future<DbLayer> conn;
        try
        {
            conn = _connect();
        }
        catch(e, s)
        {
            throw Exception('fluent db error? $e $s');
        }
        return conn;
    }
}