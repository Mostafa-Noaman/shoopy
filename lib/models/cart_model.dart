class CartModel {
  final String id;
  final String productId;
  final String title;
  final int price;
  final int quantity;
  final String imageUrl;
  final int? discount;
  final String color;
  final String size;

  CartModel(
      {required this.id,
      required this.productId,
      required this.title,
      required this.price,
      this.quantity = 1,
      required this.imageUrl,
      this.discount = 0,
      this.color = 'Black',
      required this.size});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'imgUrl': imageUrl});
    result.addAll({'discountValue': discount});
    result.addAll({'quantity': quantity});
    result.addAll({'color': color});
    result.addAll({'size': size});
    return result;
  }

  factory CartModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CartModel(
        id: documentId,
        productId: map['productId'],
        title: map['title'],
        price: map['price'],
        imageUrl: map['imgUrl'],
        size: map['size'],
        quantity: map['quantity'],
        color: map['color'],
        discount: map['discountValue']);
  }
}
