import 'package:autom_v3/utils/environment_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async
{
    await dotenv.load(fileName: ".env");

    try
    {
        final dio = Dio();
        const String cep = '95914104';

        Response response = await dio.get( EnvironmentHandler.get( EnvironmentHandler.viaCepURL ).replaceFirst('<cepVar>', cep) );
        dio.close();
        Map<String, dynamic> json =response.data;
        if( !json.containsKey('erro') )
        {
            print( json.toString() );
        }
        
        // print( response.data );
        
    }
    catch(e)
    {
        print(e);
    }
}
