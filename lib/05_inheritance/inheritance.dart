/*
Создайте иерархию классов вида спорта, который вас интересует.

Для примера возьмем киберспорт и опишем структуру классов.

  Пусть существует максимально общая сущность: человек со свойством имя.
  *Далее есть разновидность человека: геймер, который входит в какую-то команду и имеет какие-то специфичные свойства, например, количество сыгранных матчей.
  *Есть другая разновидность человека: тренер. Он тренирует какую-то команду и у него свои специфические свойства, например, количество выигранных трофеев.
  Дальше у геймера есть определенные роли или стратегии игры, у которых есть свои специфические черты.
  Пусть у каждого игрока будет предусмотрен метод вывода информации о нем.

Подумайте, какие у сущностей есть общие свойства и можно ли их перенести в родительскую сущность.
 */

abstract class Human {
  String get name;

  void myNameIs() => print('Привет, я $name!');

  @override
  String toString() => name;
}

class Gamer extends Human implements Role {
  @override
  final String name;

  @override
  RoleType role;

  int _countMatches = 0;

  Gamer({required this.name, required this.role});

  @override
  void changeRole(RoleType newRole) => role = newRole;

  void playMatch() {
    print('$name сыграл матч\n');
    _countMatches++;
  }

  @override
  String toString() => '''${super.toString()} — геймер
${getRoleGamer(role)}
Сыграно матчей: $_countMatches
===  ===  ===  \n''';
}

String getRoleGamer(RoleType role) {
  return switch (role) {
    RoleType.warrior => 'Играет: Воином',
    RoleType.paladin => 'Играет: Паладином',
    RoleType.mage => 'Играет: Магом',
    RoleType.demon => 'Играет: Демоном',
  };
}

class Trainer extends Human {
  @override
  final String name;

  int trophies = 0;

  Trainer({required this.name});

  Trainer.hasTrophies({required this.name, required this.trophies});

  void addTrophies(int value) {
    print('$name получил $value трофеев за турнир\n');
    trophies += value;
  }

  @override
  String toString() =>
      '${super.toString()} — тренер \nПолучил трофеев: $trophies\n===  ===  ===  \n';
}

enum RoleType { warrior, paladin, mage, demon }

abstract interface class Role {
  RoleType role;
  Role({required this.role});

  void changeRole(RoleType newRole);
}

class Team {
  final String name;
  final List<Gamer> gamers;
  Trainer? trainer;

  Team({required this.name, required this.gamers});

  void addGamer(Gamer gamer) => gamers.add(gamer);
  void deleteGamer(Gamer gamer) => gamers.remove(gamer);

  @override
  String toString() {
    return '''Команда "$name"
Тренер: ${trainer ?? 'Нет'}
Игроки: $gamers''';
  }
}

void main() {
  final gm = Gamer(name: 'Витя', role: RoleType.mage);
  final gm2 = Gamer(name: 'Петя', role: RoleType.warrior);
  gm.playMatch();

  gm.changeRole(RoleType.paladin);

  final team = Team(name: 'Тзе-бест', gamers: [gm]);
  team.addGamer(gm2);
  print(team);

  final tr = Trainer(name: 'Сергей Валерьевич');

  team.trainer = tr;
  print(team);

  gm.playMatch();
  gm2.playMatch();
  tr.addTrophies(3);

  final tr2 = Trainer.hasTrophies(name: 'Олег Семенович', trophies: 12);
  print(tr2);

  print(team);
}
