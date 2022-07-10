import 'transaction_item_model.dart';

class TransactionModel {
  late int id;
  late String users_address;
  late int total_price;
  late String status;
  late String payment;
  late List<TransactionItemModel> items;
  late DateTime createdAt;
  late DateTime updatedAt;

  TransactionModel({
    required this.id,
    required this.users_address,
    required this.total_price,
    required this.status,
    required this.payment,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    users_address = json['users_address'];
    total_price = int.parse(json['total_price'].toString());
    status = json['status'];
    payment = json['payment'];
    items = json['items']
        .map<TransactionItemModel>(
            (item) => TransactionItemModel.fromJson(item))
        .toList();
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_address': users_address,
      'total_price': total_price,
      'status': status,
      'payment': payment,
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
