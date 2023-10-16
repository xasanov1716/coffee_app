class CoffeeModel {
  final String name;
  final String image;
  final String price;
  final String coffeeId;
  final String description;
  final String categoryId;

  CoffeeModel(
      {required this.name,
      required this.image,
      required this.price,
      required this.description,
      required this.coffeeId,
      required this.categoryId});

  factory CoffeeModel.fromJson(Map<String, dynamic> json) => CoffeeModel(
      name: json['name'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
      coffeeId: json['coffeeId'],
      categoryId: json['categoryId']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'price': price,
        'coffeeid': coffeeId,
        'description': description,
        'categoryId': categoryId
      };
}
