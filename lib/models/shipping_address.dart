class ShippingAddress {
  final String id;
  final String fullName;
  final String country;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  ShippingAddress({
    required this.id,
    required this.fullName,
    required this.country,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.isDefault = false,
  });

  factory ShippingAddress.fromMap(Map<String, dynamic> map, String documentId) {
    return ShippingAddress(
      id: documentId,
      fullName: map["fullName"],
      country: map["country"],
      address: map["address"],
      city: map["city"],
      state: map["state"],
      zipCode: map["zipCode"],
      isDefault: map["isDefault"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fullName,
      "country": country,
      "address": address,
      "city": city,
      "state": state,
      "zipCode": zipCode,
      "isDefault": isDefault,
    };
  }
}
