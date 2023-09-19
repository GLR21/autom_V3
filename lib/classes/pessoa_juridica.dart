import 'package:autom_v3/classes/pessoa.dart';

class PessoaJuridica
        extends
            Pessoa
{
    String _cnpj = '';
    String _razaoSocial = '';
    String _nomeFantasia = '';
    String _dtRegistro = '';

    PessoaJuridica
    (
        Pessoa pessoa,
        String cnpj,
        String razaoSocial,
        String nomeFantasia,
        String dtRegistro
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
        Pessoa.tipoPessoaJuridica
    )
    {
        _cnpj = cnpj;
        _razaoSocial = razaoSocial;
        _nomeFantasia = nomeFantasia;
        _dtRegistro = dtRegistro;
    } 

    set cnpj(String cnpj)
    {
        _cnpj = cnpj;
    }

    set razaoSocial(String razaoSocial)
    {
        _razaoSocial = razaoSocial;
    }

    set nomeFantasia(String nomeFantasia)
    {
        _nomeFantasia = nomeFantasia;
    }

    set dtRegistro(String dtRegistro)
    {
        _dtRegistro = dtRegistro;
    }

    @override
    Map< String, dynamic > toMap()
    {
        Map<String, dynamic> map = super.toMap();
        int refPessoa = map['id'];
        map.clear();
        map['ref_pessoa'] = refPessoa;
        map['cnpj'] = _cnpj;
        map['razao_social'] = _razaoSocial;
        map['nome_fantasia'] = _nomeFantasia;
        map['dt_registro'] = _dtRegistro;
        return map;
    }
}
