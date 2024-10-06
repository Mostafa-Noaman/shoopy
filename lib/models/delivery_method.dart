class DeliveryMethod {
  final String id;
  final String name;
  final String imgUrl;
  final String days;
  final int price;

  DeliveryMethod({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.days,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'days': days});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'name': name});
    result.addAll({'price': price});
    return result;
  }

  factory DeliveryMethod.fromMap(Map<String, dynamic> map, String documentId) {
    return DeliveryMethod(
      id: documentId,
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      days: map['days'] ?? '',
      price: map['price'] ?? '',
    );
  }
}
