class ApiPath {
  static String products = 'products/';

  static String user(String uid) => 'users/$uid';

  static String addToCart(String uid, String addToCartId) =>
      'users/$uid/cart/$addToCartId';

  static String myProductCart(String uid) => 'users/$uid/cart/';
  static String deliveryMethods = 'deliveryMethods/';

  static String shippingAddress(String uid) => 'users/$uid/shippingAddresses';

  static String saveAddress(String uid, String addressId) =>
      'users/$uid/shippingAddresses/$addressId';

  static String addCard(String uid, String cardId) =>
      'users/$uid/cards/$cardId';

  static String cards(String uid) => 'users/$uid/cards/';
}
