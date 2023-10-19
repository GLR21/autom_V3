// ignore_for_file: empty_catches

import 'package:autom_v3/classes/peca.dart';
import 'package:autom_v3/models/peca_model.dart';

class PecaController
{
    Future<List> getAll() async
    {
        List list = await PecaModel().selectAll();
        list.map((e) => 
            Peca.empty().toObject(e)
        ).toList();

        return list;
    }

    Future<Peca> get(Peca peca) async
    {
        List list = await PecaModel().select(peca.toMap());
        return await Future.value(Peca.empty().toObject(list.first));
    }

    Future<List> getFiltered(Peca peca) async
    {
       return await PecaModel().selectQueryBuilder(peca.toMap());
    }

    void insert(Peca peca)
    {
        try
        {
            PecaModel().insert(peca.toMap());
        }
        catch(e) {}
    }

    void update(Peca peca)
    {
        try
        {
            PecaModel().update(peca.toMap());
        }
        catch(e) {}
    }

    void delete(Peca peca)
    {
        try
        {
            PecaModel().delete(peca.toMap());
        }
        catch(e) {}
    }
}