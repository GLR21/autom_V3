
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
        super.id,
        String cpf,
        String rg,
        String dataNascimento
    );

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

    @override
    Map<String, dynamic> toMap()
    {
        Map<String, dynamic> map = super.toMap();
        map['ref_pessoa'] = map['id'];
        map.remove('id');
        map['cpf'] = _cpf;
        map['rg'] = _rg;
        map['dt_nascimento'] = _dataNascimento;
        return map;
    }
}