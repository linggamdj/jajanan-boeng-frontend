import 'transaction_product_model.dart';

class TransactionItemModel {
  late int id;
  late int quantity;
  late TransactionProductModel product;

  TransactionItemModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  TransactionItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = TransactionProductModel.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product.toJson(),
    };
  }
}
