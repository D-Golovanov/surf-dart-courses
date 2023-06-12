enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  int areaInHectare;
  List<String> crops;
  List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  // Переопределяем оператор "==", что бы сравнивать объекты по значению
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

//функция получения техники из структур данных Map (принимает список из Map)
Set<AgriculturalMachinery> getMachineriesFromMap(
    List<Map<Countries, List<Territory>>> listMap) {
  Set<AgriculturalMachinery> machineriesSet = {};
  for (final map in listMap) {
    for (final value in map.values) {
      final territoryList = value;
      for (final element in territoryList) {
        machineriesSet.addAll(element.machineries);
      }
    }
  }
  return machineriesSet;
}

//функция получения возраста техники (принимает дату)
int getAgeMachinerie(DateTime date) => DateTime.now().year - date.year;

//функция расчета среднего возраста техники (принимает Set)
int averageAgeAllMachineries(Set<AgriculturalMachinery> setMachinery) {
  int averageAge = 0;
  setMachinery.forEach(
      (element) => averageAge += getAgeMachinerie(element.releaseDate));

  return (averageAge / setMachinery.length).round();
}

//функция расчета среднего возраста старой техники с учетом процента (принимает Set и процент - целое число)
int averageAgeOldMachineries(
    Set<AgriculturalMachinery> setMachinery, int percent) {
  final machineriesList = setMachinery.toList();
  final sortingList = machineriesList
    ..sort((a, b) => a.releaseDate.compareTo(b.releaseDate));

  final clampListPercent = (setMachinery.length / 100 * percent).round();

  final sortingSet = sortingList.sublist(0, clampListPercent).toSet();

  return averageAgeAllMachineries(sortingSet);
}

void main() {
  Set<AgriculturalMachinery> machineriesSet =
      getMachineriesFromMap([mapBefore2010, mapAfter2010]);

  final averageAgeAll = averageAgeAllMachineries(machineriesSet);
  final percent = 50;
  final averageAgeOldPercent =
      averageAgeOldMachineries(machineriesSet, percent);

  print('Средний возраст всей техники: $averageAgeAll');
  print(
      'Средний возраст техники для $percent% самой старой техники: $averageAgeOldPercent');
}
