
// ignore_for_file: unnecessary_getters_setters

import 'package:autom_v3/classes/pessoa.dart';

class PessoaFisica
        extends
            Pessoa
{
    String _cpf = '';
    String _rg = '';
    String _dataNascimento = '';

    PessoaFisica
    (
        Pessoa pessoa,
        String cpf,
        String rg,
        String dataNascimento
    )
    : super
    ( 
        pessoa.nome,
        pessoa.email,
        pessoa.senha,
        pessoa.telefone,
        pessoa.cep,
        pessoa.rua,
        pessoa.bairro,
        pessoa.numeroEndereco,
        pessoa.cidade,
        pessoa.complemento,
        Pessoa.tipoPessoaFisica,
        pessoa.id
    )
    {
        _cpf = cpf;
        _rg = rg;
        _dataNascimento = dataNascimento;
    }

    set cpf ( String cpf )
    {
        _cpf = cpf;
    }

    set rg ( String rg )
    {
        _rg = rg;
    }

    set dataNascimento ( String dataNascimento )
    {
        _dataNascimento = dataNascimento;
    }
    
    String get cpf => _cpf;
    String get rg => _rg;
    String get dataNascimento => _dataNascimento;

    @override
    Map<String, dynamic> toMap()
    {
        Map<String, dynamic> map = super.toMap();
        int refPessoa = map['id'];
        map.clear();
        map['ref_pessoa'] = refPessoa;
        map['cpf'] = _cpf;
        map['rg'] = _rg;
        map['dt_nascimento'] = _dataNascimento;
        return map;
    }
}