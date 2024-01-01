// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:plaka_sorgu/extensions/context_extensions.dart';
import 'package:plaka_sorgu/model/car_model.dart';

class AddNewCarPage extends StatelessWidget {
  AddNewCarPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Car newCar = Car();
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
            key: formKey,
            child: ListView(
              children: [
                Text('Araç Bilgilerini Giriniz', style: context.bigTextStyle),
                Divider(),
                SizedBox(height: 12),
                TextFormField(
                    decoration: InputDecoration(
                        label: Text('Plaka'), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Plaka boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => newCar.plate = value),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                      decoration: InputDecoration(
                          label: Text('Marka'), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Marka boş olamaz';
                        }
                        return null;
                      },
                      onSaved: (value) => newCar.brand = value),
                ),
                TextFormField(
                    decoration: InputDecoration(
                        label: Text('Renk'), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Renk boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => newCar.color = value),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                        decoration: InputDecoration(
                            label: Text('Sahip'), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sahip boş olamaz';
                          }
                          return null;
                        },
                        onSaved: (value) => newCar.owner = value)),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        formKey.currentState?.save();
                        print(newCar.toMap());
                      }
                    },
                    child: Text(
                      'Bilgileri Kaydet',
                      style: context.normalTextStyle,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}