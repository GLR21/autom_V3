import 'package:autom_v3/utils/util.dart';
import 'package:postgres/postgres.dart';

class Connection
{
  static PostgreSQLConnection? _connection;

  static Future<PostgreSQLConnection> getConnection() async 
  {

    String host = Util.getEnvirommentVariable( 'POSTGRES_DATABASE_HOST' ) ?? 'localhost';
    String port = Util.getEnvirommentVariable( 'POSTGRES_DATABASE_PORT' ) ?? '5432';
    String database = Util.getEnvirommentVariable( 'POSTGRES_DATABASE_NAME' ) ?? 'autom';
    String username = Util.getEnvirommentVariable( 'POSTGRES_DATABASE_USERNAME' ) ?? 'autom';
    String password = Util.getEnvirommentVariable( 'POSTGRES_DATABASE_PASSWORD' ) ?? 'autom';


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