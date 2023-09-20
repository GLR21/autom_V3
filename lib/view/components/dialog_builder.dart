import 'package:flutter/material.dart';

class DialogBuilder
{
    Future<dynamic> showInfoDialog(String title, String message, BuildContext context) async
    {
        return showDialog
        (
            context: context,
            builder: (context) => AlertDialog
            (
                title: Text(title),
                content: Text(message),
                actions:
                [
                    ElevatedButton
                    (
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar')
                    )
                ],
            ),
        );
    }
}