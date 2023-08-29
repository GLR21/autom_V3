
// ignore_for_file: unnecessary_getters_setters

class Estado
    extends
        Object
{
    String _nome = '';
    String _sigla = '';
    int _codIbge = 0;
    int _id = 0;

    Estado.empty();

    Estado(
        String nome,
        String sigla,
        int codIbge,
        [int id = 0]
    )
    {
        _nome = nome;
        _sigla = sigla;
        _codIbge = codIbge;
        _id = id;
    }

    int get id => _id;
    String get nome => _nome;
    String get sigla => _sigla;
    int get codIbge => _codIbge;

    set id(int id)
    {
        _id = id;
    }
    set nome(String nome)
    {
        _nome = nome;
    }
    set sigla(String sigla)
    {
        _sigla = sigla;
    }
    set codIbge(int codIbge)
    {
        _codIbge = codIbge;
    }


    Map<String, dynamic> toMap()
    {
        return 
        {
            'id': _id,
            'nome': _nome,
            'sigla': _sigla,
            'cod_ibge': _codIbge,
        };
    }

    @override
    String toString()
    {
        return 'Estado{nome: $_nome, sigla: $_sigla, codIbge: $_codIbge}';
    }
}