import 'package:json_annotation/json_annotation.dart';
import 'package:shoppers/models/product.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart extends Product {
  int count = 0;

  Cart(
    String title,
    double price,
    dynamic id, // id остается как String
    String description,
    String image,
    String category,
    this.count,
  ) : super(title, price, id, description, image, category);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
