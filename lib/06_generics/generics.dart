final articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Бородинский,500,5
''';

class Product {
  final int id;
  final String category;
  final String title;
  final int price;
  final int amount;

  Product.fromJson(List<String> list)
      : id = int.parse(list[0]),
        category = list[1],
        title = list[2],
        price = int.parse(list[3]),
        amount = int.parse(list[4]);
}

abstract interface class Filter {
  bool apply(Product product);
}

class CategoryFilter implements Filter {
  final String category;

  CategoryFilter({required this.category});

  @override
  bool apply(Product product) => product.category == category;
}

class PriceFilter implements Filter {
  final int price;

  PriceFilter({required this.price});

  @override
  bool apply(Product product) => product.price <= price;
}

class AmountFilter implements Filter {
  final int amount;

  AmountFilter({required this.amount});

  @override
  bool apply(Product product) => product.amount < amount;
}

void applyFilter<T extends Filter>(List<Product> list, T filter) {
  final filtredList = list.where((element) => filter.apply(element)).toList();
  for (var product in filtredList) {
    print(
        '${product.id}\t${product.category}\t${product.title}\t${product.price} рублей\t${product.amount} шт');
  }
}

void main() {
  final productList = articles
      .trim()
      .split('\n')
      .map((e) => Product.fromJson(e.split(',')))
      .toList();

  final categoryFilter = CategoryFilter(category: 'молоко');
  final priceFilter = PriceFilter(price: 100);
  final amountFilter = AmountFilter(amount: 50);

  print('Category filter');
  applyFilter(productList, categoryFilter);
  print('\nPrice filter');
  applyFilter(productList, priceFilter);
  print('\nAmount filter');
  applyFilter(productList, amountFilter);
}
