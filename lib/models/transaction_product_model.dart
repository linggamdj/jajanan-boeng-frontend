class TransactionProductModel {
  late int id;
  late String name;
  late int price;

  TransactionProductModel({
    required this.id,
    required this.name,
    required this.price,
  });

  TransactionProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
