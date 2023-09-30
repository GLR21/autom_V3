// ignore_for_file: empty_catches

import 'package:autom_v3/classes/cidade.dart';
import 'package:autom_v3/classes/estado.dart';
import 'package:autom_v3/models/cidade_model.dart';
import 'package:autom_v3/models/estado_model.dart';

class CidadeController
{
    Future<List> getAll() async
    {
        List list = await CidadeModel().selectAll();
        list.map((e) => 
            Cidade.empty().toObject(e)
        ).toList();

        return list;
    }

    Future<Cidade> get(Cidade cidade) async
    {
        List list = await CidadeModel().select(cidade.toMap());
        return await Future.value(Cidade.empty().toObject(list.first));
    }

    Future<List> getFiltered(Cidade cidade) async
    {
       return await CidadeModel().selectQueryBuilder(cidade.toMap());
    }

    void insert(Cidade cidade)
    {
        try
        {
            CidadeModel().insert(cidade.toMap());
        }
        catch(e) {}
    }

    void delete(Cidade cidade)
    {
        try
        {
            CidadeModel().delete(cidade.toMap());
        }
        catch(e) {}
    }
}