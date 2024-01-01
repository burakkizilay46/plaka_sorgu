// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:plaka_sorgu/components/custom_text_field.dart';
import 'package:plaka_sorgu/extensions/context_extensions.dart';
import 'package:plaka_sorgu/model/car_model.dart';
import 'package:plaka_sorgu/pages/add_new_car_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    List<Car> cars = [Car(id: 1, plate: '31R0301', brand: 'Ford Focus', color: 'Gümüş Gri', owner: 'Polis Mustafa')];
    return Scaffold(
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
                child: CustomTextField(
                  controller: _searchController,
                  labelText: 'Plaka Ara',
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                flex: 12,
                child: ListView.builder(itemBuilder: (context, index) {
                  return CarInfoCustomCard(
                    car: cars[0],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CarInfoCustomCard extends StatelessWidget {
  final Car car;
  const CarInfoCustomCard({
    Key? key,
    required this.car,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(1),
      child: Column(children: [
        Text(
          '${car.plate}',
          style: context.bigTextStyle,
        ),
        Visibility(
            child: Column(
          children: [
            Divider(),
            Text(
              '${car.owner}',
              style: context.normalTextStyle,
            ),
            Text(
              '${car.brand}',
              style: context.normalTextStyle,
            ),
            Text(
              '${car.color}',
              style: context.normalTextStyle,
            ),
          ],
        ))
      ]),
    );
  }
}
