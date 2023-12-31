// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:plaka_sorgu/components/custom_info_popup.dart';

import 'package:plaka_sorgu/extensions/context_extensions.dart';
import 'package:plaka_sorgu/model/car_model.dart';
import 'package:plaka_sorgu/provider/car_provider.dart';
import 'package:provider/provider.dart';

class AddNewCarPage extends StatelessWidget {
  final Car? selectedCar;
  AddNewCarPage({super.key, this.selectedCar});

  final formKey = GlobalKey<FormState>();

  Future<void> updateSelectedCar() async {}

  @override
  Widget build(BuildContext context) {
    final Car newCar = selectedCar ?? Car();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appBlack,
        centerTitle: true,
        title: Text(selectedCar == null ? 'Yeni Araç Ekle' : 'Araç Düzenle',
            style: context.normalTextStyle.copyWith(color: context.appWhite)),
        iconTheme: IconThemeData(color: context.appWhite),
      ),
      body: Center(
        child: Container(
          padding: context.appPadding,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(selectedCar == null ? 'Araç Bilgilerini Giriniz' : 'Seçilen Aracı Güncelle',
                    style: context.bigTextStyle),
                const Divider(),
                const SizedBox(height: 12),
                TextFormField(
                    initialValue: newCar.plate,
                    decoration: InputDecoration(
                        label: const Text('Plaka'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Plaka boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => newCar.plate = value),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextFormField(
                      initialValue: newCar.brand,
                      decoration: InputDecoration(
                          label: const Text('Marka'),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Marka boş olamaz';
                        }
                        return null;
                      },
                      onSaved: (value) => newCar.brand = value),
                ),
                TextFormField(
                    initialValue: newCar.color,
                    decoration: InputDecoration(
                        label: const Text('Renk'), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Renk boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => newCar.color = value),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                        initialValue: newCar.owner,
                        decoration: InputDecoration(
                            label: const Text('Sahip'),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Sahip boş olamaz';
                          }
                          return null;
                        },
                        onSaved: (value) => newCar.owner = value)),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(context.appBlack),
                    ),
                    onPressed: () async {
                      if (selectedCar == null && formKey.currentState!.validate() ?? false) {
                        formKey.currentState?.save();
                        CarProvider carProvider = Provider.of<CarProvider>(context, listen: false);
                        carProvider.controlIsHaveCar(newCar);
                        if (carProvider.isHave) {
                          showInfoDialog(context);
                        } else {
                          await carProvider.addCar(newCar).then((value) => Navigator.pop(context));
                        }
                      } else {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          CarProvider carProvider = Provider.of<CarProvider>(context, listen: false);
                          await carProvider.updateCar(newCar).then((value) => Navigator.pop(context));
                        }
                      }
                    },
                    child: Text(
                      'Bilgileri Kaydet',
                      style: context.normalTextStyle.copyWith(color: context.appWhite),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
