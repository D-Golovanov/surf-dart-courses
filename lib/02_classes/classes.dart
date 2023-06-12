class Plant {
  final String name;
  int? leafs;
  String position;

  Plant({required this.name, required this.position});

  void whereAreYou() => print('I\'m on the $position');
  void move(String newPlace) {
    position = newPlace;
    print('$name move $position');
  }

  @override
  String toString() => name;
}

class Flower extends Plant {
  static const String type = 'Flower';
  final Inflorescentia inflorescentia;

  Flower(
      {required this.inflorescentia,
      required super.name,
      required super.position});

  @override
  String toString() =>
      '${super.toString()} \n- type: $type \n- color: ${inflorescentia.color} \n- count flowers: ${inflorescentia.getCount}';
}

// как оказалось в растениях я не знаток
class Other extends Plant {
  static const String type = 'Other';

  Other({required super.name, required super.position});
}

class Inflorescentia {
  final String color;
  int _count = 0;

  Inflorescentia({required this.color});

  Inflorescentia.beautiful()
      : color = 'Red',
        _count = 42;

  int get getCount => _count;

  set setCount(int value) {
    (_count + value) < 0 ? _count = 0 : _count += value;
  }
}

void main(List<String> args) {
  final inflorescentiaRomashka = Inflorescentia(color: 'White');
  final romashka = Flower(
      inflorescentia: inflorescentiaRomashka,
      name: 'Romashka',
      position: 'window');

  print(romashka);

  romashka.whereAreYou();

  romashka.inflorescentia.setCount = 3;
  print(romashka);
  romashka.inflorescentia.setCount = -2;
  print(romashka);

  final rose = Flower(
      inflorescentia: Inflorescentia.beautiful(),
      name: 'Rose',
      position: 'street');
  print(rose);
  rose.whereAreYou();
  rose.move('garden');
}
