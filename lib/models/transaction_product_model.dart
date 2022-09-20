import 'package:jajanan_boeng/models/category_model.dart';

class TransactionProductModel {
  late int id;
  late String name;
  late int price;
  late CategoryModel category;

  TransactionProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  TransactionProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    category = CategoryModel.fromJson(json['category']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category.toJson(),
    };
  }
}
