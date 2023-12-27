import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppers/models/cart.dart';
import 'package:shoppers/models/product.dart';

class FirestoreUtil {
  static const String productCollection = 'product';
  static const String customerCollection = 'customers';
  static const String cartCollection = 'cart';

  static Future<List<Product>> getProducts(List<String>? ids) async {
    try {
      final productRef = FirebaseFirestore.instance
          .collection(productCollection)
          .withConverter<Product>(
              fromFirestore: (snapshot, _) =>
                  Product.fromJson(snapshot.data()!),
              toFirestore: (product, _) => product.toJson());

      QuerySnapshot<Product> productDoc;

      if (ids != null && ids.isNotEmpty) {
        productDoc = await productRef.where('id', whereIn: ids).get();
      } else {
        productDoc = await productRef.get();
      }

      return productDoc.docs.map((e) => e.data()).toList();
    } on FirebaseException catch (e, stackTrace) {
      print('Firebase Exception: $e');
      print('StackTrace: $stackTrace');
    }
    return [];
  }

  static addToCart(User? user, num productId) async {
    if (user == null) return;
    try {
      DocumentReference<Map<String, dynamic>> product = FirebaseFirestore
          .instance
          .collection(customerCollection)
          .doc(user.uid)
          .collection(cartCollection)
          .doc(productId
              .toString()); // Преобразуйте num в строку для использования в Firestore

      if ((await product.get()).exists) {
        product.update({'count': FieldValue.increment(1)});
      } else {
        product.set({'id': productId, 'count': 1});
      }
    } on FirebaseException catch (e, stackTrace) {
      print('Firebase Exception: $e');
      print('StackTrace: $stackTrace');
    }
  }

  static Future<List<Cart>> getCart(User? user) async {
    List<Cart> carts = [];
    try {
      final cartRef = await FirebaseFirestore.instance
          .collection(customerCollection)
          .doc(user?.uid)
          .collection(cartCollection)
          .get();
      List<num> productIds = [];
      for (var element in cartRef.docs) {
        productIds
            .add(num.parse(element['id'])); // Преобразуйте строку обратно в num
      }
      List<Product> products = await getProducts(productIds.cast<String>());
      for (var element in cartRef.docs) {
        Product product =
            products.firstWhere((prod) => prod.id == num.parse(element['id']));
        var json = product.toJson();
        json['count'] = element['count'];
        carts.add(Cart.fromJson(json));
      }
    } on FirebaseException catch (e, stackTrace) {
      print('Firebase Exception: $e');
      print('StackTrace: $stackTrace');
    }
    return carts;
  }

  static double getCartTotal(List<Cart> carts) {
    double total = 0;
    for (Cart cart in carts) {
      total += cart.price * cart.count;
    }
    return total;
  }
}
