class ApiPath {
  static String products = 'products/';
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid, String addToCartId) =>
      'users/$uid/cart/$addToCartId';
  static String myProductCart(String uid) => 'users/$uid/cart/';
  static String deliveryMethods = 'deliveryMethods/';
  static String shippingAddress(String uid) => 'users/$uid/shippingAddresses';
}
