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
                pessoa = PessoaJuridica( pessoa, pessoaJuridicaDados['cnpj'], pessoaJuridicaDados['razao_social'], pessoaJuridicaDados['nome_fantasia'], pessoaJuridicaDados['dt_registro'].toString() );
            break;
        }
        
        return pessoa;
    }

    Future<List> getAll( { bool onlyActive =true } ) async
    {
        List pessoasDados = await PessoaModel().selectAll();
        List<Pessoa> pessoas = [];
        for( Map<String, dynamic> pessoaDados in pessoasDados )
        {
            if( onlyActive && pessoaDados['fl_active'] == false )
            {
                continue;
            }

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
                    pessoa = PessoaJuridica( pessoa, pessoaJuridicaDados['cnpj'], pessoaJuridicaDados['razao_social'], pessoaJuridicaDados['nome_fantasia'], pessoaJuridicaDados['dt_registro'].toString() );
                break;
            }
            pessoas.add(pessoa);
        }
        return pessoas;
    }

    Future<List> getFiltered(Pessoa pessoa, { bool onlyActive = true }) async
    {
        Map <String, dynamic> filtro = pessoa.toMap();

        if( onlyActive )
        {
            filtro['fl_active'] = onlyActive;
        }

        var dadosPessoa =  await PessoaModel().selectQueryBuilder( filtro );        
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

    void update ( Pessoa pessoa )
    {
        try
        {
            /**Necessário para atualizar o registro na tabela at_pessoa, pois o objeto recebido será um objeto PessoaFisica ou PessoaJuridica,
             * que não contém os atributos da tabela at_pessoa,
             * Não é possível acessar fazer cast para pai através de um filho, em dart.
             */

            Pessoa pessoaUpdate = Pessoa
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
                pessoa.tipoPessoa,
                pessoa.id
            );

            PessoaModel().update(pessoaUpdate.toMap());

            switch( pessoa.tipoPessoa )
            {
                case Pessoa.tipoPessoaFisica:
                    PessoaFisicaModel().update(pessoa.toMap());
                break;
                case Pessoa.tipoPessoaJuridica:
                    PessoaJuridicaModel().update(pessoa.toMap());
                break;
            }
        }
        catch(e) 
        {
            print(e);
        }
    }

    void delete ( Pessoa pessoa )
    {
        try
        {
            PessoaModel().update( { 'id': pessoa.id, 'fl_active': false } );
        }
        catch(e) 
        {
            print(e);
        }
    }

    void insert ( Pessoa pessoa ) async
    {
        try
        {
            Pessoa pessoaInsert = Pessoa
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
                pessoa.tipoPessoa
            );


            var resultInsert = await PessoaModel().insert(pessoaInsert.toMap());
            pessoaInsert.id = resultInsert[0]['id'];

            switch( pessoa.tipoPessoa )
            {
                case Pessoa.tipoPessoaFisica:
                    pessoa = pessoa as PessoaFisica;
                    PessoaFisica pessoaFisica = PessoaFisica
                    (
                        pessoaInsert,
                        pessoa.cpf,
                        pessoa.rg,
                        pessoa.dataNascimento
                    );
                    PessoaFisicaModel().insert(pessoaFisica.toMap());
                break;
                case Pessoa.tipoPessoaJuridica:
                    pessoa = pessoa as PessoaJuridica;
                    PessoaJuridica pessoaJuridica = PessoaJuridica
                    (
                        pessoaInsert,
                        pessoa.cnpj,
                        pessoa.razaoSocial,
                        pessoa.nomeFantasia,
                        pessoa.dtRegistro
                    );
                    PessoaJuridicaModel().insert( pessoaJuridica.toMap());
                break;
            }
        }
        catch(e) 
        {
            print(e);
        }
    }

    Future<dynamic> getPessoaFisicaByCpf(String cpf) async
    {
        PessoaFisica pessoaFisicaForSelect = PessoaFisica.empty();
        pessoaFisicaForSelect.cpf = cpf;
        var pessoa = await PessoaFisicaModel().selectQueryBuilder(pessoaFisicaForSelect.toMap());
        if (pessoa.isEmpty)
        {
            PessoaFisica pessoa = PessoaFisica.empty();
            pessoa.id = 0;
            return pessoa;
        }

        return PessoaFisica.empty().toObject(pessoa[0]);
    }

    Future<dynamic> isHashPessoaFisicaByCpf(String cpf) async
    {
        PessoaFisica pessoaFisica = await getPessoaFisicaByCpf(cpf);
        if(pessoaFisica.id == 0)
        {
            return false;
        }

        Pessoa pessoa = Pessoa.empty();
        pessoa.id = pessoaFisica.id;
        pessoa = await PessoaController().get(pessoa);            

        if (pessoa.id == 0)
        {
            PessoaFisica pessoa = PessoaFisica.empty();
            pessoa.id = 0;
            return false;
        }

        return pessoa.senha == null || pessoa.senha!.isEmpty? false : true;
    }
}