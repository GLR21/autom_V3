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

    Future<Estado> get(Estado estado) async
    {
        List list = await EstadoModel().select(estado.toMap());
        return await Future.value(Estado.empty().toObject(list.first));
    }

    Future<List> getFiltered(Estado estado) async
    {
       return await EstadoModel().selectQueryBuilder(estado.toMap());
    }

    void insert(Estado estado)
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