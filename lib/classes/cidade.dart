
// ignore_for_file: unnecessary_getters_setters

class Cidade
    extends
        Object
{
    int _id = 0;
    String _nome = '';
    String _codIbge = '';
    int _refEstado = 0;

    Cidade.empty();

    Cidade.byId
    (
        this._id
    );

    Cidade(
        String nome,
        String codIbge,
        int refEstado,
        [int id = 0]
    )
    {
        _nome = nome;
        _codIbge = codIbge;
        _refEstado = refEstado;
        _id = id;
    }

    int get id => _id;
    String get nome => _nome;
    String get codIbge => _codIbge;
    int get refEstado => _refEstado;

    set id(int id)
    {
        _id = id;
    }
    set nome(String nome)
    {
        _nome = nome;
    }
    set codIbge(String codIbge)
    {
        _codIbge = codIbge;
    }
    set refEstado(int refEstado)
    {
        _refEstado = refEstado;
    }

    Map<String, dynamic> toMap()
    {
        return 
        {
            'id': _id,
            'nome': _nome,
            'cod_ibge': _codIbge,
            'ref_estado': _refEstado
        };
    }

    @override
    String toString()
    {
        return 'Cidade{nome: $_nome, codIbge: $_codIbge, refEstado: $_refEstado}';
    }

    Cidade toObject(Map<String, dynamic> map)
    {
        return Cidade(
            map['nome'],
            map['cod_ibge'],
            map['ref_estado'],
            map['id']
        );
    }
}