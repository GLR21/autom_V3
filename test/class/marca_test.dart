import 'package:autom_v3/classes/peca.dart';
import 'package:autom_v3/models/marca_model.dart';
import 'package:autom_v3/models/peca_model.dart';
import 'package:autom_v3/classes/marca.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async
{
    await dotenv.load(fileName: ".env");

    try
    {
        List<dynamic> marca = await MarcaModel().select( 
            {
                'id': 1
            }
        );

        var peca = Peca(
            'Teste-Peça',
            'Teste-Descricao',
            221.00,
            442.00,
            Marca.empty().toObject(marca.firstOrNull)
        );

        PecaModel().insert(peca.toMap());

    }
    catch(e)
    {
        print(e);
    }
}
