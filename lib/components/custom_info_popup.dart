import 'package:flutter/material.dart';
import 'package:plaka_sorgu/extensions/context_extensions.dart';

void showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Bilgilendirme',
          style: context.bigTextStyle,
        ),
        content: Text('Bu plakaya ait bir araç bulunmaktadır!', style: context.normalTextStyle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tamam'),
          ),
        ],
      );
    },
  );
}
