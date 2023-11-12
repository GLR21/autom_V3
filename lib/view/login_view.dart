
import 'package:autom_v3/main.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class LoginView extends StatefulWidget
{
    const LoginView({super.key});

    static const String title = 'Autenticar';

     @override
    State<StatefulWidget> createState() => _LoginViewState();
}    

class _LoginViewState extends State<LoginView>
{
    String? cpf;
    String? senha;

    Widget buildFieldCpf()
    {
        return SizedBox
        (
            width: 300,
            child: TextFormField
            (
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
                    return null;
                },
                onSaved: (newValue)
                {
                    cpf = newValue;
                }
            ),
        );
    }

    Widget buildFieldSenha()
    {
        return SizedBox
        (
            width: 300,
            child: TextFormField
            (
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
                    return null;
                },
                onSaved: (newValue)
                {
                    senha = newValue;
                }
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
            body: Column
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
                                child: const Text
                                (
                                    'Entrar',
                                    style: TextStyle(color: Colors.white),
                                ),
                                onPressed: ()
                                {
                                    Navigator.of(context).push
                                    (
                                        MaterialPageRoute
                                        (
                                            builder: (context) => openApp(),
                                        ),
                                    );
                                },
                            ),
                        ],
                    )
                ],
            )
        );
    }

    Widget openApp()
    {
       Widget app = const MyApp();

        doWhenWindowReady(()
            {
                const initialSize = Size(1440, 900);
                appWindow.minSize = const Size(1280,720);
                appWindow.size = initialSize;
                appWindow.alignment = Alignment.center;
                appWindow.show();
            }
        );

        return app;
    }
}
