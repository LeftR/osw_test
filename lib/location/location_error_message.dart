import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String text;
  final Function? callback;
  final String? buttonText;

  ErrorMessage({required this.text, this.callback, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        Icons.error_outline,
        color: Theme.of(context).primaryColor,
        size: 48,
      ),
      content: Text(text),
      actions: [
        TextButton(
          child: Text(
            buttonText != null ? buttonText! : "Ok",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          onPressed: () {
            Navigator.pop(context);
            if (callback != null) {
              callback!.call();
            }
          },
        )
      ],
    );
  }
}
