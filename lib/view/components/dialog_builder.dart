import 'package:flutter/material.dart';

class DialogBuilder
{
    void showInfoDialog(BuildContext context, String title, String message)
    {
        showDialog
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
            )
        );  
    }
}