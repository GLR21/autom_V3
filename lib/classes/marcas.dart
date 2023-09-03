
// ignore_for_file: unnecessary_getters_setters

class Marcas
    extends
        Object
{
    int _id = 0;
    String _nome = '';

    Marcas.empty();

    Marcas(
        String nome,
        [int id = 0]
    )
    {
        _nome = nome;
        _id = id;
    }

    int get id => _id;
    String get nome => _nome;

    set id(int id)
    {
        _id = id;
    }
    set nome(String nome)
    {
        _nome = nome;
    }

    Map<String, dynamic> toMap()
    {
        return 
        {
            'id': _id,
            'nome': _nome,
        };
    }

    @override
    String toString()
    {
        return 'Marcas{id: $_id, nome: $_nome}';
    }

    Marcas toObject(Map<String, dynamic> map)
    {
        return Marcas(
            map['nome'],
            map['id']
        );
    }
}