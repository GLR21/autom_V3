import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/classes/pessoa_fisica.dart';
import 'package:autom_v3/classes/pessoa_juridica.dart';
import 'package:autom_v3/models/pessoa_fisica_model.dart';
import 'package:autom_v3/models/pessoa_juridica_model.dart';
import 'package:autom_v3/models/pessoa_model.dart';

class PessoaController
{
    Future<Pessoa> get(Pessoa pessoa) async
    {
        List pessoaDados = await PessoaModel().select(pessoa.toMap());
        pessoa = Pessoa.empty().toObject(pessoaDados.first);
        
        Map<String, dynamic> filtroById = { 'ref_pessoa': pessoa.id };
        switch( pessoa.tipoPessoa )
        {
            case Pessoa.tipoPessoaFisica:
                dynamic pessoaFisicaDados = await PessoaFisicaModel().select( filtroById );
                pessoaFisicaDados = pessoaFisicaDados.first;
                pessoa = PessoaFisica( pessoa, pessoaFisicaDados['cpf'], pessoaFisicaDados['rg'], pessoaFisicaDados['dt_nascimento'].toString() );
            break;
            case Pessoa.tipoPessoaJuridica:
                dynamic pessoaJuridicaDados = await PessoaJuridicaModel().select(filtroById);
                pessoaJuridicaDados = pessoaJuridicaDados.first;
                pessoa = PessoaJuridica( pessoa, pessoaJuridicaDados['cnpj'], pessoaJuridicaDados['razao_social'], pessoaJuridicaDados['nome_fantasia'], pessoaJuridicaDados['dt_fundacao'].toString() );
            break;
        }
        
        return pessoa;
    }

    Future<Pessoa> getOnlyPessoa(Pessoa pessoa) async
    {
        List list = await PessoaModel().select(pessoa.toMap());
        if (list.isEmpty)
        {
            return Future.value(Pessoa.empty());
        }
        return await Future.value(Pessoa.empty().toObject(list.first));
    }

    Future<List> getAll() async
    {
        List pessoasDados = await PessoaModel().selectAll();
        List<Pessoa> pessoas = [];
        for( Map<String, dynamic> pessoaDados in pessoasDados )
        {
            Pessoa pessoa = Pessoa.empty().toObject(pessoaDados);
            Map<String, dynamic> filtroById = { 'ref_pessoa': pessoa.id };
            switch( pessoa.tipoPessoa )
            {
                case Pessoa.tipoPessoaFisica:
                    dynamic pessoaFisicaDados = await PessoaFisicaModel().select( filtroById );
                    if (!pessoaFisicaDados.isEmpty)
                    {
                        pessoaFisicaDados = pessoaFisicaDados.first;
                        pessoa = PessoaFisica( pessoa, pessoaFisicaDados['cpf'], pessoaFisicaDados['rg'], pessoaFisicaDados['dt_nascimento'].toString() ); 
                    }
                break;
                case Pessoa.tipoPessoaJuridica:
                    dynamic pessoaJuridicaDados = await PessoaJuridicaModel().select(filtroById);
                    if (!pessoaJuridicaDados.isEmpty)
                    {
                        pessoaJuridicaDados = pessoaJuridicaDados.first;
                        pessoa = PessoaJuridica( pessoa, pessoaJuridicaDados['cnpj'], pessoaJuridicaDados['razao_social'], pessoaJuridicaDados['nome_fantasia'], pessoaJuridicaDados['dt_fundacao'].toString() );
                    }
                break;
            }
            pessoas.add(pessoa);
        }
        return pessoas;
    }

    Future<List> getFiltered(Pessoa pessoa) async
    {
        var dadosPessoa =  await PessoaModel().selectQueryBuilder(pessoa.toMap());
        var list = dadosPessoa.map((pessoa) =>
            Pessoa(
                pessoa['nome'] ?? '',
                pessoa['email'] ?? '',
                pessoa['senha'] ?? '',
                pessoa['telefone'] ?? '',
                pessoa['cep'] ?? '',
                pessoa['rua'] ?? '',
                pessoa['bairro'] ?? '',
                pessoa['numero_endereco'] ?? 0,
                pessoa['ref_cidade'] ?? 0,
                pessoa['complemento'] ?? '',
                pessoa['tipo_pessoa'] ?? 0,
                pessoa['id'] ?? 0
            )
        ).toList();

        return Future.value(list);
    }

    void insert(Pessoa pessoa)
    {
        try
        {
            PessoaModel().insert(pessoa.toMap());
        }
        catch(e) {}
    }

    void update(Pessoa pessoa)
    {
        try
        {
            PessoaModel().update(pessoa.toMap());
        }
        catch(e) {}
    }

    void delete(Pessoa pessoa)
    {
        try
        {
            PessoaModel().delete(pessoa.toMap());
        }
        catch(e) {}
    }
}