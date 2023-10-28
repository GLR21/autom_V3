
// ignore_for_file: unnecessary_getters_setters

class Pessoa
    extends
        Object
{
    
    static const int tipoPessoaFisica   = 1;
    static const int tipoPessoaJuridica = 2;

    int _id = 0;
    String _nome = '';
    String _email = '';
    String _senha = '';
    String _telefone = '';
    String _cep = '';
    String _rua = '';
    String _bairro = '';
    int    _numeroEndereco = 0;
    int    _cidade = 1;
    int _tipoPessoa = 3;
    String _complemento = '';

    Pessoa
    (  
        String nome,
        String email,
        String senha,
        String telefone,
        String cep,
        String rua,
        String bairro,
        int numeroEndereco,
        int cidade,
        String complemento ,
        [   
            int tipoPessoa = 0,
            int id = 0
        ]
    )
    {
        _id = id;
        _nome = nome;
        _email = email;
        _senha = senha;
        _telefone = telefone;
        _cep = cep;
        _rua = rua;
        _bairro = bairro;
        _numeroEndereco = numeroEndereco;
        _cidade = cidade;
        _tipoPessoa = tipoPessoa;
        _complemento = complemento;
    }

    Pessoa.empty();

    Pessoa.byId
    (
        this._id
    );

    int get id => _id;
    String get nome => _nome;
    String get email => _email;
    String get senha => _senha;
    String get telefone => _telefone;
    String get cep => _cep;
    String get rua => _rua;
    String get bairro => _bairro;
    int    get numeroEndereco => _numeroEndereco;
    int    get cidade => _cidade;
    int    get tipoPessoa => _tipoPessoa;
    String get complemento => _complemento;

    set id ( int id )
    {
        _id = id;
    }

    set nome ( String nome )
    {
        _nome = nome;
    }

    set email ( String email )
    {
        _email = email;
    }

    set senha ( String senha )
    {
        _senha = senha;
    }

    set telefone ( String telefone )
    {
        _telefone = telefone;
    }

    set cep ( String cep )
    {
        _cep = cep;
    }

    set rua ( String rua )
    {
        _rua = rua;
    }

    set bairro ( String bairro )
    {
        _bairro = bairro;
    }

    set numeroEndereco ( int numeroEndereco )
    {
        _numeroEndereco = numeroEndereco;
    }

    set cidade ( int cidade )
    {
        _cidade = cidade;
    }

    set tipoPessoa ( int tipoPessoa )
    {
        _tipoPessoa = tipoPessoa;
    }

    set complemento ( String complemento )
    {
        _complemento = complemento;
    }

    Map<String, dynamic > toMap()
    {
        return
        {
            'id': _id,
            'nome': _nome,
            'email': _email,
            'senha': _senha,
            'telefone': _telefone,
            'sys_auth': 3,
            'cep': _cep,
            'rua': _rua,
            'bairro': _bairro,
            'numero_endereco': _numeroEndereco,
            'ref_cidade': _cidade,
            'tipo_pessoa': _tipoPessoa,
            'complemento': _complemento,
        };
    }

    @override
    String toString()
    {
        return 'Pessoa{id: $_id, nome: $_nome, email: $_email, senha: $_senha, telefone: $_telefone, cep: $_cep, rua: $_rua, bairro: $_bairro, tipoPessoa: $_tipoPessoa, complemento: $_complemento}';
    }

    Pessoa toObject(Map<String, dynamic> map)
    {
        return Pessoa
        (
            map['nome'],
            map['email'],
            map['senha'],
            map['telefone'],
            map['cep'],
            map['rua'],
            map['bairro'],
            map['numero_endereco'],
            map['ref_cidade'],
            map['complemento'],
            map['tipo_pessoa'],
            map['id'],
        );
    }

}