// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:plaka_sorgu/components/custom_confirm_popup.dart';

import 'package:plaka_sorgu/components/custom_text_field.dart';
import 'package:plaka_sorgu/extensions/context_extensions.dart';
import 'package:plaka_sorgu/model/car_model.dart';
import 'package:plaka_sorgu/pages/add_new_car_page.dart';
import 'package:plaka_sorgu/provider/car_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNewCarPage()),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: context.appBlack,
          centerTitle: true,
          title: Text('Plaka Sorgu', style: context.normalTextStyle.copyWith(color: context.appWhite)),
        ),
        body: Center(
          child: Container(
            padding: context.appPadding,
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      label: Text('Plaka Ara'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onChanged: (value) {
                      Provider.of<CarProvider>(context, listen: false).filterCars(value);
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Flexible(
                    flex: 12,
                    child: Consumer<CarProvider>(
                      builder: (context, carProvider, child) {
                        List<Car> cars = carProvider.isFilter ? carProvider.filteredCars : carProvider.cars;
                        if (cars.isEmpty && !carProvider.isFilter) {
                          return Center(
                            child: Text(
                              'Lütfen Araç Ekleyin!',
                              style: context.normalTextStyle,
                            ),
                          );
                        } else if (cars.isEmpty && carProvider.isFilter) {
                          return Center(
                              child: Text(
                            'Araç bulunamadı!',
                            style: context.bigTextStyle,
                          ));
                        } else {
                          return ListView.builder(
                              itemCount: cars.length,
                              itemBuilder: (context, index) => CarInfoCustomCard(
                                    car: cars[index],
                                    provider: carProvider,
                                  ));
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CarInfoCustomCard extends StatelessWidget {
  final Car car;
  final CarProvider provider;
  const CarInfoCustomCard({
    Key? key,
    required this.car,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCarPage(selectedCar: car)));
      },
      child: Dismissible(
        confirmDismiss: (direction) => showConfirmationDialog(context, 'DİKKAT!', 'Silmek istediğinize emin misiniz?'),
        onDismissed: (direction) async {
          await provider.deleteCar(car);
        },
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 32, right: 16),
            child: Text(
              'Sil',
              style: TextStyle(color: context.appWhite, fontSize: 32),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        key: ValueKey(car.id),
        child: Card(
          color: context.appBlack,
          key: ValueKey(car.id),
          child: Column(children: [
            cardText(context, '${car.plate}'),
            Visibility(
                child: Column(
              children: [
                const Divider(),
                cardText(context, '${car.owner}'),
                cardText(context, '${car.brand}'),
                cardText(context, '${car.color}')
              ],
            ))
          ]),
        ),
      ),
    );
  }

  Text cardText(BuildContext context, String data) {
    return Text(
      data,
      style: data == car.plate
          ? context.bigTextStyle.copyWith(color: context.appWhite)
          : context.normalTextStyle.copyWith(color: context.appWhite),
    );
  }
}
