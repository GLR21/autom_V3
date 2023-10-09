// ignore_for_file: empty_catches

import 'package:autom_v3/classes/marca.dart';
import 'package:autom_v3/models/marca_model.dart';

class MarcaController
{
    Future<List> getAll() async
    {
        List list = await MarcaModel().selectAll();
        list.map((e) => 
            Marca.empty().toObject(e)
        ).toList();

        return list;
    }

    Future<Marca> get(Marca marca) async
    {
        List list = await MarcaModel().select(marca.toMap());
        return await Future.value(Marca.empty().toObject(list.first));
    }

    Future<List> getFiltered(Marca marca) async
    {
       return await MarcaModel().selectQueryBuilder(marca.toMap());
    }

    void insert(Marca marca)
    {
        try
        {
            MarcaModel().insert(marca.toMap());
        }
        catch(e) {}
    }

    void update(Marca marca)
    {
        try
        {
            MarcaModel().update(marca.toMap());
        }
        catch(e) {}
    }

    void delete(Marca marca)
    {
        try
        {
            MarcaModel().delete(marca.toMap());
        }
        catch(e) {}
    }
}