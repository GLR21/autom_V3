
// ignore_for_file: unnecessary_getters_setters

import 'package:autom_v3/classes/marca.dart';

class Peca
    extends
        Object
{
    int _id = 0;
    String _nome = '';
    String _descricao = '';
    num _valorCompra = 0.00;
    num _valorRevenda = 0.00;
    Marca _refMarca = Marca.empty();

    Peca(
        String nome,
        String descricao,
        num valorCompra,
        num valorRevenda,
        Marca refMarca,
        [int id = 0]
    )
    {
        _nome = nome;
        _descricao = descricao;
        _valorCompra = valorCompra;
        _valorRevenda = valorRevenda;
        _refMarca = refMarca;
        _id = id;
    }

    Peca.empty();

    int get id => _id;
    String get nome => _nome;
    String get descricao => _descricao;
    num get valorCompra => _valorCompra;
    num get valorRevenda => _valorRevenda;
    Marca get refMarca => _refMarca;

    set id(int id)
    {
        _id = id;
    }
    set nome(String nome)
    {
        _nome = nome;
    }
    set descricao(String descricao)
    {
        _descricao = descricao;
    }
    set valorCompra(num valorCompra)
    {
        _valorCompra = valorCompra;
    }
    set valorRevenda(num valorRevenda)
    {
        _valorRevenda = valorRevenda;
    }
    set refMarca(Marca refMarca)
    {
        _refMarca = refMarca;
    }

    Map<String, dynamic> toMap()
    {
        return 
        {
            'id': _id,
            'nome': _nome,
            'descricao': _descricao,
            'valor_compra': _valorCompra,
            'valor_revenda': _valorCompra,
            'ref_marca': _refMarca.id
        };
    }

    @override
    String toString()
    {
        return 'Marcas{id: $_id, nome: $_nome, descricao: $_descricao, valorCompra: $_valorCompra, valorRevenda: $_valorRevenda, refMarca: $_refMarca}';
    }
}