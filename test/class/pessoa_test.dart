import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/classes/pessoa_fisica.dart';
import 'package:autom_v3/classes/pessoa_juridica.dart';
import 'package:autom_v3/models/pessoa_fisica_model.dart';
import 'package:autom_v3/models/pessoa_juridica_model.dart';
import 'package:autom_v3/models/pessoa_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async
{
    await dotenv.load(fileName: ".env");

    try
    {
        PessoaModel pessoaModel = PessoaModel();
        // PessoaFisicaModel pessoaFisicaModel = PessoaFisicaModel();
        PessoaJuridicaModel pessoaJuridicaModel = PessoaJuridicaModel();

        // Pessoa pessoa = Pessoa
        // (
        //     'Teste',
        //     'test@gmail',
        //     'teste123',
        //     '999999999',
        //     '99999999',
        //     'Rua teste',
        //     'Bairro teste',
        //     999,
        //     1,
        //     'Complemento teste',
        //     Pessoa.tipoPessoaFisica
        // );

        // Como declarar uma pessoa física
        // PessoaFisica pessoaFisica = PessoaFisica
        // (
        //     pessoa,
        //     '99999999999',
        //     '999999999',
        //     '01/01/2000'
        // );

        // Como inserir uma pessoa física. Deve ser inserido primeiro na tabela at_pessoa e depois na tabela at_pessoa_fisica
        // var result = await pessoaModel.insert(pessoa.toMap());

        //Deve ser implementado assim no futuro
        // var mapPessoaFisica = pessoaFisica.toMap();
        // mapPessoaFisica['ref_pessoa'] = result[0]['id'];

        // print( await pessoaFisicaModel.insert(mapPessoaFisica) );

        // Como declarar uma pessoa jurídica

        Pessoa pessoa2 = Pessoa
        (
            'Teste juridica',
            'test@gmail',
            'Teste juridica123',
            '999999999',
            '99999999',
            'Rua Teste juridica',
            'Bairro Teste juridica',
            999,
            1,
            'Complemento Teste juridica',
            Pessoa.tipoPessoaJuridica
        );

        // Como declarar uma pessoa jurídica

        PessoaJuridica pessoaJuridica = PessoaJuridica
        (
            pessoa2,
            '99999999999999',
            'Razão social teste',
            'Nome fantasia teste',
            '01/01/2000'
        );
        // Como inserir uma pessoa jurídica. Deve ser inserido primeiro na tabela at_pessoa e depois na tabela at_pessoa_juridica

        var result2 = await pessoaModel.insert(pessoa2.toMap());

        //Deve ser implementado assim no futuro
        var mapPessoaJuridica = pessoaJuridica.toMap();
        mapPessoaJuridica['ref_pessoa'] = result2[0]['id'];

        print( await pessoaJuridicaModel.insert(mapPessoaJuridica) );
    }
    catch(e)
    {
        print(e);
    }
}
