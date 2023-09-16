import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/models/estado_model.dart';

class EstadoController
{
    Future<List> getAll() async
    {
        List list = await EstadoModel().selectAll();
        list.map((e) => 
            Estado.empty().toObject(e)
        ).toList();

        return list;
    }

    Future<List> getFiltered(Estado estado) async
    {
       return await EstadoModel().selectQueryBuilder(estado.toMap());
    }

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