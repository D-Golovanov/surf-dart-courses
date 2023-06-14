typedef Strategy = double Function(List<String>, List<String>);

class PokerPlayer {
  /// Список текущих карт в руке у игрока
  List<String> _currentHand = ['King of clubs', 'Nine of hearts'];

  /// Субъективная оценка выигрыша
  double _surenessInWin = 0;

  /// Вычислить шансы на выигрыш
  void calculateProbabilities(
    List<String> cardOnDesk,

    /// Это часть первого задания. [Strategy] пока не сущестивует.
    ///
    /// Опишите его.
    Strategy strategy,
  ) =>
      _surenessInWin = strategy(cardOnDesk, _currentHand);
}

void main() {
  final opponent = PokerPlayer();

  /// Это часть первого задания. [Strategy] пока не сущестивует.
  ///
  /// Опишите его.
  final Strategy fakeStrategy = (p0, p1) {
    print(p1);
    return 1.0;
  };

  opponent.calculateProbabilities(
    ['Nine of diamonds', 'king of hearts'],
    fakeStrategy,
  );
}

/*
 Если вы просто скопируете этот код, он не скомпилируется, это нормально!
 1. Сейчас типа Strategy не существует, вам требуется описать его так, чтобы программа работала 
 (изменять другой код вам при этом не требуется). Подсказка по реализации находится в теории, которую вы прошли.
 2. Опишите эту стратегию так, чтобы карты противников выводились в консоль!
 */