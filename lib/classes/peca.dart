
// ignore_for_file: unnecessary_getters_setters
class Peca
    extends
        Object
{
    int _id = 0;
    String _nome = '';
    String _descricao = '';
    num _valorCompra = 0.00;
    num _valorRevenda = 0.00;
    int _refMarca = 0;

    Peca(
        String nome,
        String descricao,
        num valorCompra,
        num valorRevenda,
        int refMarca,
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

    Peca.byId
    (
        this._id
    );

    int get id => _id;
    String get nome => _nome;
    String get descricao => _descricao;
    num get valorCompra => _valorCompra;
    num get valorRevenda => _valorRevenda;
    int get refMarca => _refMarca;

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
    set refMarca(int refMarca)
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
            'ref_marca': _refMarca
        };
    }

    @override
    String toString()
    {
        return 'Marcas{id: $_id, nome: $_nome, descricao: $_descricao, valorCompra: $_valorCompra, valorRevenda: $_valorRevenda, refMarca: $_refMarca}';
    }

    Peca toObject(Map<String, dynamic> map)
    {
        return Peca(
            map['nome'],
            map['descricao'] ?? '',
            num.parse(map['valor_compra']),
            num.parse(map['valor_revenda']),
            map['ref_marca'],
            map['id']
        );
    }
}