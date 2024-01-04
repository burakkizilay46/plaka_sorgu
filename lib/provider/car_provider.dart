import 'package:flutter/material.dart';
import 'package:plaka_sorgu/database/database_helper.dart';
import 'package:plaka_sorgu/model/car_model.dart';

class CarProvider extends ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => _cars;

  bool _isHave = false;
  bool get isHave => _isHave;

  CarProvider() {
    _loadCars();
  }

  Future<void> _loadCars() async {
    _cars = await DatabaseHelper.instance.getCars();
    notifyListeners();
  }

  void controlIsHaveCar(Car car) async {
    _isHave = _cars.where((element) => element.plate == car.plate).isNotEmpty;
  }

  Future<void> addCar(Car car) async {
    if (!_isHave) {
      await DatabaseHelper.instance.insertCar(car);
      _loadCars();
    }

    notifyListeners();
    _isHave = false;
  }

  Future<void> deleteCar(Car car) async {
    await DatabaseHelper.instance.deleteCar(car.id!).then((value) => _loadCars());
    notifyListeners();
  }
}
