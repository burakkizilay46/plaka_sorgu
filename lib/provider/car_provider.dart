import 'package:flutter/material.dart';
import 'package:plaka_sorgu/database/database_helper.dart';
import 'package:plaka_sorgu/model/car_model.dart';

class CarProvider extends ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => _cars;

  CarProvider() {
    _loadCars();
  }

  Future<void> _loadCars() async {
    _cars = await DatabaseHelper.instance.getCars();
    notifyListeners();
  }

  void addCar(Car car) async {
    await DatabaseHelper.instance.insertCar(car);
    notifyListeners();
  }

  void deleteCar(int id) async {
    await DatabaseHelper.instance.deleteCar(id);
    notifyListeners();
  }
}
