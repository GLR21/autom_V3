
import 'package:autom_v3/view/components/navigation_panel.dart';
import 'package:autom_v3/view/marca/marca_view.dart';
import 'package:autom_v3/view/peca/peca_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget
{
    const MainView({super.key});

    static const String title = 'Autom';

    @override
    Widget build(BuildContext context) => Scaffold
    (
        appBar: AppBar
        (
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text
            (
                MainView.title,
                style: TextStyle
                (
                    color: Colors.white, fontWeight: FontWeight.w500
                ),
            )
        ),
        drawer: const NavigationPanel(),
        body: Center
        (
            child: Wrap
            (
                children:
                [
                    Column
                    (
                        children:
                        [
                            Row
                            (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                [
                                    SizedBox.fromSize /// Cadastrar Peça
                                    (
                                        size: const Size(150, 150),
                                        child: ClipRRect
                                        (
                                            borderRadius: BorderRadius.circular(15),
                                            child: Material
                                            (
                                                color: Colors.green.shade600,
                                                child: InkWell
                                                (
                                                    // splashColor: Colors.green,
                                                    onTap: () 
                                                    {
                                                        Navigator.of(context).push
                                                        (
                                                            MaterialPageRoute
                                                            (
                                                                builder: (context) => const PecaView(null),
                                                            ),
                                                        );
                                                    },
                                                    child: const Column
                                                    (
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children:
                                                        [
                                                            Icon
                                                            (
                                                                Icons.settings,
                                                                size: 50,
                                                                color: Colors.white
                                                            ),
                                                            Text("Cadastrar Peça", style: TextStyle(color: Colors.white)),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ),
                                    const Padding
                                    (
                                        padding: EdgeInsets.all(15)
                                    ),
                                    SizedBox.fromSize /// Cadastrar Marca
                                    (
                                        size: const Size(150, 150),
                                        child: ClipRRect
                                        (
                                            borderRadius: BorderRadius.circular(15),
                                            child: Material
                                            (
                                                color: Colors.green.shade600,
                                                child: InkWell
                                                (
                                                    // splashColor: Colors.green,
                                                    onTap: () 
                                                    {
                                                        Navigator.of(context).push
                                                        (
                                                            MaterialPageRoute
                                                            (
                                                                builder: (context) => const MarcaView(null),
                                                            ),
                                                        );
                                                    },
                                                    child: const Column
                                                    (
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children:
                                                        [
                                                            Icon
                                                            (
                                                                Icons.storefront_outlined,
                                                                size: 50,
                                                                color: Colors.white
                                                            ),
                                                            Text("Cadastrar Marca", style: TextStyle(color: Colors.white)),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                        ),
                                    )
                                ],
                            )
                        ],
                    )
                ],
            ),
        ),
    );
}
