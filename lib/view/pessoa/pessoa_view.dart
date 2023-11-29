
import 'package:autom_v3/classes/cidade.dart';
import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/classes/pessoa_fisica.dart';
import 'package:autom_v3/classes/pessoa_juridica.dart';
import 'package:autom_v3/controllers/cidade_controller.dart';
import 'package:autom_v3/controllers/pessoa_controller.dart';
import 'package:autom_v3/utils/environment_handler.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:autom_v3/view/pessoa/pessoa_list_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PessoaView extends StatefulWidget
{
    final int? id;

    const PessoaView( this.id, { super.key } );  

    @override
    State<PessoaView> createState() => _PessoaViewState();
}

class _PessoaViewState extends State<PessoaView>
{
    

    Future<Pessoa> pessoa = Future.value(Pessoa.empty());
    Future<List> allCidades = CidadeController().getAll();
    int? selectedCidade;

    // Pessoa
    String? idPessoa;
    String? nome;
    String? email;
    String? senha;
    String? telefone;
    String? cep;
    String? rua;
    String? bairro;
    String? numeroEndereco;
    String? complemento;
    int? cidade;
    int? tipoPessoa;
    
    // PessoaFisica
    String? cpf;
    String? rg;
    DateTime selectedDate = DateTime.now();
    String? dataNascimento;


    // PessoaJuridica
    String? cnpj;
    String? razaoSocial;
    String? nomeFantasia;
    String? dataRegistro;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    
    // Pessoa
    late final TextEditingController idController;
    late final TextEditingController nomeController;
    late final TextEditingController emailController;
    late final TextEditingController telefoneController;
    late final TextEditingController cepController;
    late final TextEditingController ruaController;
    late final TextEditingController bairroController;
    late final TextEditingController numeroEnderecoController;
    late final TextEditingController complementoController;
    // PessoaFisica
    late final TextEditingController cpfController;
    late final TextEditingController rgController;
    late final TextEditingController dataNascimentoController;
    // PessoaJuridca 
    late final TextEditingController cnpjController;
    late final TextEditingController razaoSocialController;
    late final TextEditingController nomeFantasiaController;
    late final TextEditingController dataRegistroController;
    
    @override
    void initState()
    {
        super.initState();
        idController                = TextEditingController(text: idPessoa ?? '');
        nomeController              = TextEditingController(text: nome ?? '');
        emailController             = TextEditingController(text: email ?? '');
        telefoneController          = TextEditingController(text: telefone ?? '');
        cepController               = TextEditingController(text: cep ?? '');
        ruaController               = TextEditingController(text: null );
        bairroController            = TextEditingController(text: bairro ?? '');
        numeroEnderecoController    = TextEditingController(text: numeroEndereco ?? '');
        complementoController       = TextEditingController(text: complemento ?? '');
        
        cpfController               = TextEditingController(text: cpf ?? '');
        rgController                = TextEditingController(text: rg ?? '');
        dataNascimentoController    = TextEditingController(text: dataNascimento ?? '');

        cnpjController              = TextEditingController(text: cnpj ?? '');
        razaoSocialController       = TextEditingController(text: razaoSocial ?? '');
        nomeFantasiaController      = TextEditingController(text: nomeFantasia ?? '');
        dataRegistroController      = TextEditingController(text: dataRegistro ?? '');
    }
    
    @override
    void dispose()
    {
        idController.dispose();
        nomeController.dispose();
        emailController.dispose();
        telefoneController.dispose();
        cepController.dispose();
        ruaController.dispose();
        bairroController.dispose();
        numeroEnderecoController.dispose();
        complementoController.dispose();
        
        cpfController.dispose();
        rgController.dispose();
        dataNascimentoController.dispose();
        
        cnpjController.dispose();
        razaoSocialController.dispose();
        nomeFantasiaController.dispose();
        dataRegistroController.dispose();

        super.dispose();
    }

    @override
    Widget build(BuildContext context)
    {
        bool isEdit = false;
        int? id = widget.id;

        if(id != null)
        {
            isEdit = true;
            pessoa = PessoaController().get(Pessoa.byId(id));
        }
        return Scaffold
        (
            appBar: AppBar
            (
                title: const Text
                (
                    'Pessoa',
                    style: TextStyle
                    (
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                ),
                backgroundColor: Colors.greenAccent
            ),
            body: Scaffold
            (
                body: SingleChildScrollView
                (
                    child:
                    Padding
                    (
                        padding: const EdgeInsets.all(10),

                        child:
                        
                        Center
                        (
                            child:
                            Container
                            (
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                child: FutureBuilder
                                (
                                    future: pessoa,
                                    builder: (context, snapshot)
                                    {
                                        if( snapshot.connectionState == ConnectionState.waiting )
                                        {
                                            return const Center
                                            (
                                                child: CircularProgressIndicator()
                                            );
                                        }

                                        if(snapshot.hasError)
                                        {
                                            return Text('Error: ${snapshot.error}');
                                        }
                                        else
                                        {
                                            var pessoa =  snapshot.data!;
                                            if( isEdit )
                                            {
                                                idController.text = idController.text.isEmpty ? pessoa.id.toString() : idController.text;
                                                nomeController.text = nomeController.text.isEmpty ? pessoa.nome : nomeController.text;
                                                emailController.text = emailController.text.isEmpty ? pessoa.email : emailController.text;
                                                senha = pessoa.senha;
                                                telefoneController.text = telefoneController.text.isEmpty ? pessoa.telefone : telefoneController.text;
                                                cepController.text = cepController.text.isEmpty ? pessoa.cep : cepController.text;
                                                
                                                ruaController.text = ruaController.text.isEmpty ? pessoa.rua : ruaController.text;

                                                bairroController.text = bairroController.text.isEmpty ? pessoa.bairro : bairroController.text;
                                                cidade = selectedCidade == null ? pessoa.cidade : selectedCidade as int;
                                                numeroEnderecoController.text = numeroEnderecoController.text.isEmpty ? pessoa.numeroEndereco.toString() : numeroEnderecoController.text;
                                                complementoController.text = complementoController.text.isEmpty ? pessoa.complemento : complementoController.text;
                                                tipoPessoa = tipoPessoa == null ? pessoa.tipoPessoa : tipoPessoa as int;

                                                switch( tipoPessoa )
                                                {
                                                    case Pessoa.tipoPessoaFisica:
                                                        cpfController.text = cpfController.text.isEmpty ? (pessoa as PessoaFisica).cpf : cpfController.text;
                                                        rgController.text = rgController.text.isEmpty ? (pessoa as PessoaFisica).rg : rgController.text;
                                                        selectedDate =  dataNascimentoController.text.isEmpty ?  DateTime.parse((pessoa as PessoaFisica).dataNascimento) : DateTime.parse(dataNascimentoController.text) ;
                                                    break;
                                                    case Pessoa.tipoPessoaJuridica:
                                                        cnpjController.text = cnpjController.text.isEmpty ? (pessoa as PessoaJuridica).cnpj : cnpjController.text;
                                                        razaoSocialController.text = razaoSocialController.text.isEmpty ? (pessoa as PessoaJuridica).razaoSocial : razaoSocialController.text;
                                                        nomeFantasiaController.text = nomeFantasiaController.text.isEmpty ? (pessoa as PessoaJuridica).nomeFantasia : nomeFantasiaController.text;
                                                        selectedDate =  dataRegistroController.text.isEmpty ?  DateTime.parse((pessoa as PessoaJuridica).dtRegistro) : DateTime.parse(dataRegistroController.text) ;
                                                    break;
                                                }

                                            }

                                            else
                                            {
                                                tipoPessoa = tipoPessoa ?? Pessoa.tipoPessoaFisica;
                                                selectedCidade = selectedCidade ?? 0;
                                                cidade = selectedCidade as int;

                                                switch( tipoPessoa )
                                                {
                                                    case Pessoa.tipoPessoaFisica:
                                                        selectedDate =  dataNascimentoController.text.isEmpty ?  selectedDate : DateTime.parse(dataNascimentoController.text) ;
                                                    break;
                                                    case Pessoa.tipoPessoaJuridica:
                                                        selectedDate =  dataRegistroController.text.isEmpty ?  selectedDate : DateTime.parse(dataRegistroController.text) ;
                                                    break;
                                                }
                                            }
                                            
                                            return
                                            
                                            Form
                                            (
                                                key: formKey,
                                                child: Column
                                                (
                                                    children: <Widget>
                                                    [
                                                        (
                                                            isEdit ?

                                                            Row
                                                            (
                                                                children:
                                                                [
                                                                    Expanded
                                                                    (
                                                                        flex: 1,
                                                                        child: ListTile
                                                                        (
                                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                            subtitle: buildFieldId()
                                                                        ) 
                                                                    ),

                                                                    const SizedBox
                                                                    (
                                                                        width: 1
                                                                    ),

                                                                    Expanded
                                                                    (
                                                                        flex: 5,
                                                                        child: ListTile
                                                                        (
                                                                            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                            subtitle: buildFieldNome(),
                                                                        ) 
                                                                    )    
                                                                ],
                                                            )
                                                            :
                                                            ListTile
                                                            (
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                title: buildFieldNome(),
                                                            )
                                                        ),
                                                        
                                                        const SizedBox
                                                        (
                                                            height: 2
                                                        ),
                                                        
                                                        Row
                                                        (
                                                            children:
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldEmail(),
                                                                    ) 
                                                                )    
                                                            ]
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),

                                                        Row
                                                        (
                                                            children: 
                                                            [
                                                                Expanded
                                                                (
                                                                    flex:  1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldTelefone(),
                                                                    )
                                                                )
                                                            ],
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),

                                                        Row
                                                        (
                                                            children: 
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 2,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldCEP(),
                                                                    )
                                                                ),

                                                                const SizedBox
                                                                (
                                                                    width: 1
                                                                ),

                                                                Expanded
                                                                (
                                                                    flex:  4,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldRua(),
                                                                    )
                                                                )
                                                            ],
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),

                                                        Row
                                                        (
                                                            children:
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 5,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildFieldBairro(),
                                                                    )
                                                                ),

                                                                const SizedBox
                                                                (
                                                                    width: 1
                                                                ),

                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildNumeroEndereco(),
                                                                    )
                                                                )
                                                            ],
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),

                                                        Row
                                                        (
                                                            children:
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildComboCidade(),
                                                                    )
                                                                )
                                                            ],
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),

                                                        Row
                                                        (
                                                            children: 
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        subtitle: buildComplemento(),
                                                                    ) ,
                                                                )
                                                            ],
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),
                                                        
                                                        Row
                                                        (
                                                            children:
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        title: AbsorbPointer( absorbing: ( idController.text.isEmpty ? false :  int.parse( idController.text ) > 0 ), child: buildSwitchTipoPessoa() ),
                                                                    ),
                                                                )
                                                            ],
                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),

                                                        (
                                                            tipoPessoa == Pessoa.tipoPessoaFisica ?
                                                            buildCamposPessoaFisica() : buildCamposPessoaJuridica()

                                                        ),

                                                        const SizedBox
                                                        (
                                                            height: 5
                                                        ),

                                                        Row
                                                        (
                                                            children:
                                                            [
                                                                Expanded
                                                                (
                                                                    flex: 1,
                                                                    child: 
                                                                    ListTile
                                                                    (
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                                                        title: 
                                                                        ElevatedButton
                                                                        (
                                                                            style: ElevatedButton.styleFrom
                                                                            (
                                                                                backgroundColor: Colors.green,
                                                                                foregroundColor: Colors.white,
                                                                                shape: RoundedRectangleBorder
                                                                                (
                                                                                    borderRadius: BorderRadius.circular(4.0),
                                                                                ),
                                                                            ),
                                                                            child: Text
                                                                            (
                                                                                isEdit ? 'Atualizar' : 'Salvar',
                                                                                style: const TextStyle(color: Colors.white),
                                                                            ),
                                                                            onPressed: ()
                                                                            {
                                                                                if(!formKey.currentState!.validate())
                                                                                {
                                                                                    return;
                                                                                }

                                                                                if(!isEdit)
                                                                                {
                                                                                    /* Inserir */
                                                                                    formKey.currentState!.save();

                                                                                    Pessoa pessoaInsert = Pessoa
                                                                                    (
                                                                                        nome!,
                                                                                        email!,
                                                                                        null,
                                                                                        telefone!,
                                                                                        cep!,
                                                                                        rua!,
                                                                                        bairro!,
                                                                                        int.parse(numeroEndereco!),
                                                                                        cidade!,
                                                                                        complemento!,
                                                                                        tipoPessoa!
                                                                                    );

                                                                                    switch( tipoPessoa )
                                                                                    {
                                                                                        case Pessoa.tipoPessoaFisica:
                                                                                            pessoaInsert = PessoaFisica( pessoaInsert, cpf!, rg!, selectedDate.toString() );
                                                                                        break;
                                                                                        case Pessoa.tipoPessoaJuridica:
                                                                                            pessoaInsert = PessoaJuridica( pessoaInsert, cnpj!, razaoSocial!, nomeFantasia!, selectedDate.toString() );
                                                                                        break;
                                                                                    }

                                                                                    PessoaController().insert( pessoaInsert );

                                                                                    DialogBuilder().showInfoDialog
                                                                                    (
                                                                                        'Sucesso',
                                                                                        'Estado inserido com sucesso',
                                                                                        context
                                                                                    ).then((value) =>
                                                                                        Navigator.of(context).push
                                                                                        (
                                                                                            MaterialPageRoute
                                                                                            (
                                                                                                builder: (context) => const PessoaListView()
                                                                                            ),
                                                                                        )
                                                                                    );
                                                                                }
                                                                                else
                                                                                {
                                                                                    /* Atualizar  */
                                                                                    formKey.currentState!.save();
                                                                                    Pessoa pessoaUpdate = Pessoa
                                                                                    (
                                                                                        nome!,
                                                                                        email!,
                                                                                        senha!.isEmpty || senha == null ? null : senha,
                                                                                        telefone!,
                                                                                        cep!,
                                                                                        rua!,
                                                                                        bairro!,
                                                                                        int.parse(numeroEndereco!),
                                                                                        cidade!,
                                                                                        complemento!,
                                                                                        tipoPessoa!,
                                                                                        int.parse(idPessoa!)
                                                                                    );

                                                                                    switch( tipoPessoa )
                                                                                    {
                                                                                        case Pessoa.tipoPessoaFisica:
                                                                                            pessoaUpdate = PessoaFisica( pessoaUpdate, cpf!, rg!, selectedDate.toString() );
                                                                                        break;
                                                                                        case Pessoa.tipoPessoaJuridica:
                                                                                            pessoaUpdate = PessoaJuridica( pessoaUpdate, cnpj!, razaoSocial!, nomeFantasia!, selectedDate.toString() );
                                                                                        break;
                                                                                    }

                                                                                    PessoaController().update( pessoaUpdate );
                                                                                    
                                                                                    DialogBuilder().showInfoDialog
                                                                                    (
                                                                                        'Sucesso',
                                                                                        'Estado atualizado com sucesso',
                                                                                        context
                                                                                    ).then((value) =>

                                                                                        Navigator.of(context).push
                                                                                        (
                                                                                            MaterialPageRoute
                                                                                            (
                                                                                                builder: (context) => const PessoaListView()
                                                                                            ),
                                                                                        )
                                                                                    );

                                                                                    /* Limpar form */
                                                                                    formKey.currentState!.reset();
                                                                                }
                                                                            },
                                                                        )
                                                                    )
                                                                )
                                                            ],
                                                        )
                                                    ],
                                                )
                                            );
                                        }
                                    },
                                ),
                            )
                        )
                    )
                    
                )
            ) 
        );
    }

    Widget buildFieldId()
    {
        return TextFormField
        (
            controller: idController,
            enabled: false,
            decoration: const InputDecoration
            (
                label: Text('Código'),
                border: OutlineInputBorder()
            ),
            onSaved: (value)
            {
                idPessoa = value!;
            },
        );
    }

    Widget buildFieldNome()
    {
        return TextFormField
        (
            controller: nomeController,
            decoration: const InputDecoration
            (
                label: Text('Nome'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                nomeController.text = value;
            },
            onSaved: (value)
            {
                nome = value;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o nome';
                }
                return null;
            },
        );
    }

    Widget buildFieldEmail()
    {
        return TextFormField
        (
            controller: emailController,
            decoration: const InputDecoration
            (
                label: Text('Email'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                emailController.text = value;
            },
            onSaved: (value)
            {
                email = value;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o email';
                }
                return null;
            },
        );
    }

    Widget buildFieldTelefone()
    {
        return TextFormField
        (
            controller: telefoneController,
            decoration: const InputDecoration
            (
                label: Text('Telefone'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                telefoneController.text = value;
            },
            onSaved: (value)
            {
                telefone = value;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o telefone';
                }
                return null;
            },
        );
    }

    Widget buildFieldCEP()
    {

        return Focus
        (
            child: 
            TextFormField
            (
                controller: cepController,
                decoration: const InputDecoration
                (
                    label: Text('CEP'),
                    border: OutlineInputBorder()
                ),
                onChanged: (value)
                {
                    cepController.text = value;
                },
                onSaved: (value)
                {
                    cep = value;
                },
                validator: (value)
                {
                    if(value!.isEmpty)
                    {
                        return 'Informe o CEP';
                    }
                    return null;
                },
            ),
            onFocusChange: (hasFocus) async 
            {
                if( !hasFocus )
                {
                    var json = await findByCep( cepController.text );
                    if( json.isNotEmpty )
                    {
                        var cidade = await CidadeController().getFiltered( Cidade.byCodigoIbge(json['ibge']) );
                        setState(()
                        {
                            ruaController.text = json['logradouro'];
                            bairroController.text = json['bairro'];
                            selectedCidade = cidade.first['id'];
                        });
                    }
                }
            },
        );
    }

    Widget buildFieldRua( )
    {
        return TextFormField
        (
            controller: ruaController,
            decoration: const InputDecoration
            (
                label: Text('Rua'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                print( value );
                ruaController.text = value;
            },
            onSaved: (value)
            {
                rua = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe a rua';
                }
                return null;
            },
        );
    }

    Widget buildFieldBairro()
    {
        return TextFormField
        (
            controller: bairroController,
            decoration: const InputDecoration
            (
                label: Text('Bairro'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                bairroController.text = value;
            },
            onSaved: (value)
            {
                bairro = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o bairro';
                }
                return null;
            },
        );
    }

    Widget buildNumeroEndereco()
    {
        return TextFormField
        (
            controller: numeroEnderecoController,
            decoration: const InputDecoration
            (
                label: Text('Número'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                numeroEnderecoController.text = value;
            },
            onSaved: (value)
            {
                numeroEndereco = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o número';
                }
                return null;
            },
        );
    }

    Widget buildComplemento()
    {
        return TextFormField
        (
            controller: complementoController,
            decoration: const InputDecoration
            (
                label: Text('Complemento'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                complementoController.text = value;
            },
            onSaved: (value)
            {
                complemento = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o complemento';
                }
                return null;
            },
        );
    }

    FutureBuilder buildComboCidade()
    {
        return FutureBuilder<List<dynamic>>
        (
            future: allCidades,
            builder: (context, snapshot)
            {
                if( snapshot.connectionState == ConnectionState.waiting )
                {}

                if(snapshot.hasError)
                {
                    return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData)
                {
                    var items = snapshot.data!;
                    var map = items.map((map) =>
                        DropdownMenuItem
                        (
                            value: map['id'],
                            child: Text(map['nome'])
                        )
                    );
                    var list = map.toList();
                    list.insert
                    (
                        0,
                        const DropdownMenuItem
                        (
                            value: 0,
                            child: Text('Selecione uma cidade')
                        )
                    );


                    return DropdownButtonFormField
                    (
                        isExpanded: true,
                        value: cidade,
                        hint: const Text('Selecione uma cidade'),
                        items: list,
                    
                        onChanged: (value) 
                        {
                            setState(() 
                            {
                                selectedCidade = value as int;
                                cidade = value;

                            });
                        },
                        validator: (value)
                        {
                            if(value == null)
                            {
                                return 'Selecione uma cidade!';
                            }
                            return null;
                        },
                        onSaved: (value)
                        {
                            cidade = value as int;
                        },
                    );
                }
                else
                {
                    return DropdownButton
                    (
                        items: const [],
                        onChanged: (item) => setState(() {}),
                    );
                }
            },
        );
    }
    
    Widget buildSwitchTipoPessoa()
    {
        String titleTipoPessoa = tipoPessoa == Pessoa.tipoPessoaFisica ? 'Física' : 'Jurídica';
        bool isNew = idController.text.isEmpty ? true : int.parse( idController.text ) == 0;
        return SwitchListTile
        (
            title: Text('Tipo de pessoa: $titleTipoPessoa'),
            value: tipoPessoa ==  Pessoa.tipoPessoaFisica ? true : false,
            onChanged: (value) => 
            (
                isNew ? 
                setState(() 
                {
                    tipoPessoa = value ? Pessoa.tipoPessoaFisica : Pessoa.tipoPessoaJuridica;

                }):
                null
            ) ,
            activeColor: Colors.green,
            secondary: Icon( tipoPessoa == Pessoa.tipoPessoaFisica ? Icons.person : Icons.business_center ),
        );
    }

    Widget buildFieldCPF()
    {
        return TextFormField
        (
            controller: cpfController,
            decoration: const InputDecoration
            (
                label: Text('CPF'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                cpfController.text = value;
            },
            onSaved: (value)
            {
                cpf = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o CPF';
                }
                return null;
            },
        );
    }

    Widget buildFieldRG()
    {
        return TextFormField
        (
            controller: rgController,
            decoration: const InputDecoration
            (
                label: Text('RG'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                rgController.text = value;
            },
            onSaved: (value)
            {
                rg = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o RG';
                }
                return null;
            },
        );
    }

    Widget buildFieldCNPJ()
    {
        return TextFormField
        (
            controller: cnpjController,
            decoration: const InputDecoration
            (
                label: Text('CNPJ'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                cnpjController.text = value;
            },
            onSaved: (value)
            {
                cnpj = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o CNPJ';
                }
                return null;
            },
        );
    }

    Widget buildFieldRazaoSocial()
    {
        return TextFormField
        (
            controller: razaoSocialController,
            decoration: const InputDecoration
            (
                label: Text('Razão social'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                razaoSocialController.text = value;
            },
            onSaved: (value)
            {
                razaoSocial = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe a razão social';
                }
                return null;
            },
        );
    }

    Widget buildFieldNomeFantasia()
    {
        return TextFormField
        (
            controller: nomeFantasiaController,
            decoration: const InputDecoration
            (
                label: Text('Nome fantasia'),
                border: OutlineInputBorder()
            ),
            onChanged: (value)
            {
                nomeFantasiaController.text = value;
            },
            onSaved: (value)
            {
                nomeFantasia = value!;
            },
            validator: (value)
            {
                if(value!.isEmpty)
                {
                    return 'Informe o nome fantasia';
                }
                return null;
            },
        );
    }

    Widget buildCamposPessoaFisica()
    {
        return Column
        (
            children: 
            [
                const SizedBox
                (
                    height: 5
                ),

                Row
                (
                    children: 
                    [
                        Expanded
                        (
                            flex: 1,
                            child: ListTile
                            (
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                subtitle: buildFieldCPF(),
                            )
                        )
                    ],
                ),

                const SizedBox
                (
                    height: 5
                ),

                Row
                (
                    children: 
                    [
                        Expanded
                        (
                            flex: 1,
                            child: ListTile
                            (
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                subtitle: buildFieldRG(),
                            )
                        )
                    ],
                ),

                const SizedBox
                (
                    height: 5
                ),

                Row
                (
                    children: 
                    [
                        Expanded
                        (
                            flex: 1,
                            child: ListTile
                            (
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                title: const Text('Data de nascimento'),
                                subtitle: buildDatePicker(),
                            )
                        )
                    ],
                ),
            ],
        );
    }

    Widget buildCamposPessoaJuridica()
    {
        return Column
        (
            children: 
            [
                const SizedBox
                (
                    height: 5
                ),

                Row
                (
                    children: 
                    [
                        Expanded
                        (
                            flex: 1,
                            child: ListTile
                            (
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                subtitle: buildFieldCNPJ(),
                            )
                        ),
                        
                        Expanded
                        (
                            flex: 1,
                            child: ListTile
                            (
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                subtitle: buildFieldRazaoSocial(),
                            )
                        )
                    ],
                ),

                const SizedBox
                (
                    height: 5
                ),

                Row
                (
                    children: 
                    [
                        Expanded
                        (
                            flex: 1,
                            child: ListTile
                            (
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                subtitle: buildFieldNomeFantasia(),
                            )
                        )
                    ],
                ),

                const SizedBox
                (
                    height: 5
                ),

                Row
                (
                    children: 
                    [
                        Expanded
                        (
                            flex: 1,
                            child: ListTile
                            (
                                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                                title: const Text('Data de registro'),
                                subtitle: buildDatePicker(),
                            )
                        )
                    ],
                ),
            ],
        );
    }

    Widget buildDatePicker()
    {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');

        return TextButton
        (
            style: ButtonStyle
            (
                shape: MaterialStateProperty.all<RoundedRectangleBorder>
                (
                    RoundedRectangleBorder
                    (
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(color: Colors.black54)
                    )
                )
            ),
            onPressed: () async
            {
                final DateTime? picked = await showDatePicker
                (
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                );
                if (picked != null && picked != selectedDate)
                {
                    setState(()
                    {
                        switch( tipoPessoa )
                        {
                            case Pessoa.tipoPessoaFisica:
                                dataNascimentoController.text = picked.toUtc().toString();
                            break;
                            case Pessoa.tipoPessoaJuridica:
                                dataRegistroController.text = picked.toUtc().toString();
                            break;
                        }
                    });
                }
            },
            child: Text
            (
              formatter.format( selectedDate  ),
              style: const TextStyle(color: Colors.black),

            ),
        );
    }


    Future<dynamic> findByCep( String cep ) async
    {
        try
        {
            cep = cep.replaceAll('-', '');
            Dio dio = Dio();
            Response response = await dio.get( EnvironmentHandler.get( EnvironmentHandler.viaCepURL ).replaceFirst('<cepVar>', cep) );
            dio.close();
            Map<String, dynamic> json =response.data;
            if( !json.containsKey('erro') )
            {
                return json;
            }
            else
            {
                return {};
            }
        }
        catch(e)
        {
            return {};
        }
    }
}