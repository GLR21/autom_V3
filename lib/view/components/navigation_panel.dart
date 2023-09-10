import 'package:autom_v3/view/estado/estado_list_view.dart';
import 'package:autom_v3/view/estado/estado_view.dart';
import 'package:autom_v3/view/main_view.dart';
import 'package:flutter/material.dart';

class NavigationPanel extends StatelessWidget
{
    const NavigationPanel({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                    buildHeader(context),
                    buildMenuItems(context)
                ],
            )
        )
    );

    Widget buildHeader(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 17)
    );

    Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(23),
        child: Wrap(
        runSpacing: 17,
            children: [
                ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: const Text('Principal', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push(
                               PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) => const MainView(),
                                ),
                        )
                ),
                const Divider(color: Colors.black54,),
                ListTile(
                    leading: const Icon(Icons.account_balance_outlined),
                    title: const Text('Estados', style: TextStyle(fontWeight: FontWeight.w500),),
                    onTap: () =>
                        Navigator.of(context).push(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation1, animation2) => const EstadoListView(),
                                ),
                        )
                ),
            ],
        ),
    );
}