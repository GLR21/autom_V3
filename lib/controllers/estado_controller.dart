import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/models/estado_model.dart';

class EstadoController
{
    insert(Estado estado)
    {
        try
        {
            EstadoModel().insert(estado.toMap());
        }
        catch(e)
        {
            print(e);
        }
    }
}