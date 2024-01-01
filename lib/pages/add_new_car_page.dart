import 'package:flutter/material.dart';
import 'package:plaka_sorgu/components/custom_text_field.dart';
import 'package:plaka_sorgu/extensions/context_extensions.dart';

class AddNewCarPage extends StatelessWidget {
  const AddNewCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController plateController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    TextEditingController pownerController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appBlack,
        centerTitle: true,
        title: Text('Yeni Arac Ekle', style: context.normalTextStyle.copyWith(color: context.appWhite)),
        iconTheme: IconThemeData(color: context.appWhite),
      ),
      body: Center(
        child: Container(
          padding: context.appPadding,
          child: Form(
            child: Column(
              children: [
                CustomTextField(labelText: 'Plaka', controller: plateController),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CustomTextField(labelText: 'Marka', controller: brandController),
                ),
                CustomTextField(labelText: 'Renk', controller: colorController),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CustomTextField(labelText: 'Sahibi', controller: pownerController),
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Bilgileri Kaydet'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
