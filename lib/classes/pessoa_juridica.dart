import 'package:autom_v3/classes/pessoa.dart';

class PessoaJuridica
        extends
            Pessoa
{
    String _cnpj;
    String _razaoSocial;
    String _nomeFantasia;
    String _dtRegistro;

    PessoaJuridica
    (
        super.nome,
        super.email,
        super.senha,
        super.telefone,
        super.cep,
        super.rua,
        super.bairro,
        super.numeroEndereco,
        super.cidade,
        super.tipoPessoa,
        super.complemento,
        this._cnpj,
        this._razaoSocial,
        this._nomeFantasia,
        this._dtRegistro
    );

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
        map['ref_pessoa'] = map['id'];
        map['cnpj'] = _cnpj;
        map['razao_social'] = _razaoSocial;
        map['nome_fantasia'] = _nomeFantasia;
        map['dt_registro'] = _dtRegistro;

        map.remove('id');
        return map;
    }
}
