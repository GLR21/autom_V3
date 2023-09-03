import 'package:autom_v3/models/pecas_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:autom_v3/classes/marcas.dart';
import 'package:autom_v3/classes/pecas.dart';
import 'package:autom_v3/models/marcas_model.dart';

void main() async
{
    await dotenv.load(fileName: ".env");

    try
    {
        List<dynamic> marca = await MarcasModel().select( 
            {
                'id': 1
            }
        );

        var peca = Pecas(
            'Teste-Peça',
            'Teste-Descricao',
            221.00,
            442.00,
            Marcas.empty().toObject(marca.firstOrNull)
        );

        PecasModel().insert(peca.toMap());

    }
    catch(e)
    {
        print(e);
    }
}
