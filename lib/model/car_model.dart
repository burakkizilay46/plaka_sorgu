class Car {
  int? id;
  String? plate;
  String? brand;
  String? color;
  String? owner;

  Car({
    this.id,
    this.plate,
    this.brand,
    this.color,
    this.owner,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plate': plate,
      'brand': brand,
      'color': color,
      'owner': owner,
    };
  }

  Car.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        plate = map['plate'],
        brand = map['brand'],
        color = map['color'],
        owner = map['owner'];
}
