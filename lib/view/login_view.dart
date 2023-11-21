
import 'dart:convert';

import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/controllers/pessoa_controller.dart';
import 'package:autom_v3/main.dart';
import 'package:autom_v3/view/components/dialog_builder.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class LoginView extends StatefulWidget
{
    const LoginView({super.key});

    static const String title = 'Login';

     @override
    State<StatefulWidget> createState() => _LoginViewState();
}    

class _LoginViewState extends State<LoginView>
{
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? cpf;
    String? senha;
    String? senhaRegister;

    late final TextEditingController cpfController;
    late final TextEditingController senhaController;

    bool showCpfInput = true;
    bool showSenhaInput = true;
    bool showLoginButton = true;
    bool doRegister = false;

    @override
    void initState()
    {
        super.initState();

        cpfController = TextEditingController(text: cpf ?? '');
        senhaController = TextEditingController(text: senha ?? '');
    }

    @override
    void dispose()
    {
        super.dispose();

        cpfController.dispose();
        senhaController.dispose();
    }

    void hideDefaultInputs()
    {
        setState(()
        {
            showCpfInput = false;
            showLoginButton = false;
        });
    }

    void unhideDefaultInputs()
    {
        setState(()
        {
            showCpfInput = true;
            showLoginButton = true;
        });
    }

    Widget buildFieldCpf()
    {
        return SizedBox
        (
            width: 300,
            child: Visibility
            (
                visible: showCpfInput,
                child: TextFormField
                (
                    controller: cpfController,
                    maxLength: 11,
                    decoration: const InputDecoration
                    (
                        label: Text
                        (
                            'CPF'
                        ),
                        border: OutlineInputBorder()
                    ),
                    validator: (String? value)
                    {
                        if(value!.isEmpty)
                        {
                            return '"CPF" é obrigatório';
                        }
                        return null;
                    },
                    onChanged: (value)
                    {
                        cpfController.text = value;
                    },
                    onSaved: (newValue)
                    {
                        cpf = newValue!;
                    }
                ),
            ),
        );
    }

    Widget buildFieldSenha()
    {
        return SizedBox
        (
            width: 300,
            child: Visibility
            (
                visible: showSenhaInput,
                child: TextFormField
                (
                    controller: senhaController,
                    obscureText: true,
                    decoration: const InputDecoration
                    (
                        label: Text
                        (
                            'Senha'
                        ),
                        border: OutlineInputBorder()
                    ),
                    validator: (String? value)
                    {
                        if(value!.isEmpty)
                        {
                            return '"Senha" é obrigatória';
                        }
                        return null;
                    },
                    onChanged: (value)
                    {
                        senhaController.text = value;
                    },
                    onSaved: (newValue)
                    {
                        senha = newValue;
                    }
                )
            ),
        );
    }

    @override
    Widget build(BuildContext context)
    {     
        return Scaffold
        (
            appBar: AppBar
            (
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text
                (
                    LoginView.title,
                    style: TextStyle
                        (
                            color: Colors.white, fontWeight: FontWeight.w500
                        ),
                ),
            ),
            body: Form
            (
                key: formKey,
                child: Column
                (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [
                        Row
                        (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                                buildFieldCpf()
                            ],
                        ),
                        const Padding(padding: EdgeInsets.all(5),),
                        Row
                        (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                                buildFieldSenha()
                            ],
                        ),
                        const Padding(padding: EdgeInsets.all(5),),
                        Row
                        (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
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
                                        showLoginButton ? 'Entrar' : 'Cadastrar',
                                        style: const TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async
                                    {
                                        if(!formKey.currentState!.validate())
                                        {
                                            return;
                                        }

                                        formKey.currentState!.save();

                                        cpfController.text = cpfController.text.isEmpty ? cpf! : cpfController.text;
                                        senhaController.text = senhaController.text.isEmpty ? senha! : senhaController.text;

                                        var isAuthenticated = await validateLogin(cpfController.text, senhaController.text);
                                        if(await isHashSenha(cpf))
                                        {
                                            if(isAuthenticated)
                                            {
                                                routeToApp();
                                            }
                                            else
                                            {
                                                showPasswordLoginWarning();
                                            }
                                        }
                                        else if(await isCpf(cpf) && ! await isHashSenha(cpf))
                                        {
                                            hideDefaultInputs();
                                            if(doRegister)
                                            {
                                                if(await registerPassword(cpfController.text, senhaController.text))
                                                {
                                                    showPasswordRegisterSucess();
                                                    unhideDefaultInputs();
                                                }
                                            }
                                            setState(()
                                            {
                                                doRegister = true;
                                                senhaController.text = '';
                                            });
                                        }
                                    },
                                ),
                            ],
                        )
                    ],
                )
            )
        );
    }

    void showPasswordLoginWarning() async
    {
        DialogBuilder().showInfoDialog('Erro', 'Dados de login estão incorretos.', context);
    }

    void showPasswordRegisterSucess() async
    {
        DialogBuilder().showInfoDialog('Sucesso', 'Nova senha cadastrada com sucesso!', context);
    }

    void routeToApp() async
    {
        Navigator.of(context).push
        (
            MaterialPageRoute
            (
                builder: (context) => openApp(),
            ),
        );
    }

    Widget openApp()
    {
       Widget app = const MyApp();

        doWhenWindowReady(()
            {
                const initialSize = Size(1366, 768);
                appWindow.minSize = const Size(1280,720);
                appWindow.size = initialSize;
                appWindow.alignment = Alignment.center;
                appWindow.show();
            }
        );

        return app;
    }

    Future<bool> validateLogin(String? cpf, String? senha) async
    {
        var refPessoa = await PessoaController().getIdPessoaFisicaByCpf(cpf!);
        if(refPessoa == 0)
        {
            return false;
        }
        var pessoa = await PessoaController().get(Pessoa.byId(refPessoa));
        var hash = pessoa.senha;

        if(md5.convert(utf8.encode(senha!)).toString() == hash)
        {
            return true;
        }
        return false;
    }

    Future<bool> registerPassword(String? cpf, String? senha) async
    {
        var refPessoa = await PessoaController().getIdPessoaFisicaByCpf(cpf!);
        if(refPessoa == 0)
        {
            return false;
        }
        var pessoa = await PessoaController().get(Pessoa.byId(refPessoa));

        pessoa.senha = md5.convert(utf8.encode(senha!)).toString();
        PessoaController().update(pessoa);

        return true;
    }

    Future<bool> isCpf(String? cpf) async
    {
        var refPessoa = await PessoaController().getIdPessoaFisicaByCpf(cpf!);
        if(refPessoa == 0)
        {
            return false;
        }
        return true;
    }

    Future<bool> isHashSenha(String? cpf) async
    {
        return await PessoaController().isHashPessoaFisicaByCpf(cpf!);
    }
}
