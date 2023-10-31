import 'package:autom_v3/view/cidade/cidade_list_view.dart';
import 'package:autom_v3/view/estado/estado_list_view.dart';
import 'package:autom_v3/view/main_view.dart';
import 'package:autom_v3/view/marca/marca_list_view.dart';
import 'package:autom_v3/view/peca/peca_list_view.dart';
import 'package:autom_v3/view/pessoa/pessoa_list_view.dart';
import 'package:flutter/material.dart';

class NavigationPanel extends StatelessWidget
{
    const NavigationPanel({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) => Drawer
    (
        child: SingleChildScrollView
        (
            child: Column
            (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                    buildHeader(context),
                    buildMenuItems(context)
                ],
            )
        )
    );

    Widget buildHeader(BuildContext context) => Container
    (
        padding: const EdgeInsets.only(top: 17)
    );

    Widget buildMenuItems(BuildContext context) => Container
    (
        padding: const EdgeInsets.all(23),
        child: Wrap
        (
            runSpacing: 17,
            children:
            [
                ListTile
                (
                    leading: const Icon(Icons.home_outlined),
                    title: const Text('Principal', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push
                        (
                            MaterialPageRoute
                            (
                                builder: (context) => const MainView(),
                            ),
                        )
                ),
                const Divider(color: Colors.black54,),
                ListTile
                (
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Peças', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push
                        (
                            MaterialPageRoute
                            (
                                builder: (context) => const PecaListView(),
                            ),
                        )
                ),
                ListTile
                (
                    leading: const Icon(Icons.storefront_outlined),
                    title: const Text('Marcas', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push
                        (
                            MaterialPageRoute
                            (
                                builder: (context) => const MarcaListView(),
                            ),
                        )
                ),
                const Divider(color: Colors.black54,),
                                ListTile
                (
                    leading: const Icon(Icons.person_2_outlined),
                    title: const Text('Pessoas', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push
                        (
                            MaterialPageRoute
                            (
                                builder: (context) => const PessoaListView(),
                            ),
                        )
                ),
                const Divider(color: Colors.black54,),
                ListTile
                (
                    leading: const Icon(Icons.account_balance_outlined),
                    title: const Text('Estados', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push
                        (
                            MaterialPageRoute
                            (
                                builder: (context) => const EstadoListView(),
                            ),
                        )
                ),
                ListTile
                (
                    leading: const Icon(Icons.location_city_outlined),
                    title: const Text('Cidades', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push
                        (
                            MaterialPageRoute
                            (
                                builder: (context) => const CidadeListView(),
                            ),
                        )
                ),
            ],
        ),
    );
}