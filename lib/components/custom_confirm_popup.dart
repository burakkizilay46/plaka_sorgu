import 'package:flutter/material.dart';
import 'package:plaka_sorgu/extensions/context_extensions.dart';

Future<bool> showConfirmationDialog(BuildContext context, String messageHeader, String contentMessage) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(messageHeader, style: context.bigTextStyle),
        content: Text(
          contentMessage,
          style: context.normalTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Silmeyi iptal et
            },
            child: const Text("Hayır"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Silmeyi onayla
            },
            child: const Text("Evet"),
          ),
        ],
      );
    },
  );
}
