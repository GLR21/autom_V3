import 'package:autom_v3/utils/environment_handler.dart';
import 'package:postgres/postgres.dart';

class Connection
{

    static getInstance()
    {
        return PostgreSQLConnection
        (
            EnvironmentHandler.get('POSTGRES_DATABASE_HOST'),
            int.parse(EnvironmentHandler.get('POSTGRES_DATABASE_PORT')),
            EnvironmentHandler.get('POSTGRES_DATABASE_NAME'),
            username: EnvironmentHandler.get('POSTGRES_DATABASE_USERNAME'),
            password: EnvironmentHandler.get('POSTGRES_DATABASE_PASSWORD'),
        );
    }
}