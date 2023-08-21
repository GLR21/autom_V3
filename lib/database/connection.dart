import 'package:autom_v3/utils/environment_handler.dart';
import 'package:postgres/postgres.dart';

class Connection
{
  static PostgreSQLConnection? _connection;

    static Future<PostgreSQLConnection> getConnection() async 
    {
        String host = EnvironmentHandler.get('POSTGRES_DATABASE_HOST');
        String port = EnvironmentHandler.get('POSTGRES_DATABASE_PORT');
        String database = EnvironmentHandler.get('POSTGRES_DATABASE_NAME');
        String username = EnvironmentHandler.get('POSTGRES_DATABASE_USERNAME');
        String password = EnvironmentHandler.get('POSTGRES_DATABASE_PASSWORD');

        if (_connection == null)
        {
            _connection = PostgreSQLConnection
                        (
                        host,
                        int.parse( port ),
                        database,
                        username: username,
                        password: password
                        );

            await _connection!.open();
        }

        return _connection!;
    }
}