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
                    pessoaFisicaDados = pessoaFisicaDados.first;
                    pessoa = PessoaFisica( pessoa, pessoaFisicaDados['cpf'], pessoaFisicaDados['rg'], pessoaFisicaDados['dt_nascimento'].toString() );
                break;
                case Pessoa.tipoPessoaJuridica:
                    dynamic pessoaJuridicaDados = await PessoaJuridicaModel().select(filtroById);
                    pessoaJuridicaDados = pessoaJuridicaDados.first;
                    pessoa = PessoaJuridica( pessoa, pessoaJuridicaDados['cnpj'], pessoaJuridicaDados['razao_social'], pessoaJuridicaDados['nome_fantasia'], pessoaJuridicaDados['dt_fundacao'].toString() );
                break;
            }
            pessoas.add(pessoa);
        }
        return pessoas;
    }
}