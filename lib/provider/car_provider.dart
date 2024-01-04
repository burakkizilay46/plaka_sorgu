import 'package:flutter/material.dart';
import 'package:plaka_sorgu/database/database_helper.dart';
import 'package:plaka_sorgu/model/car_model.dart';

class CarProvider extends ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => _cars;
  List<Car> _filteredCars = [];
  List<Car> get filteredCars => _filteredCars;

  bool _isFilter = false;
  bool get isFilter => _isFilter;

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

  Future<void> updateCar(Car updatedCar) async {
    await DatabaseHelper.instance.updateCar(updatedCar);
    notifyListeners();
  }

  void filterCars(String plate) {
    if (plate.isEmpty) {
      _isFilter = false;
    } else {
      _isFilter = true;
      _filteredCars = cars.where((element) => element.plate!.contains(plate)).toList();
    }
    notifyListeners();
  }
}
