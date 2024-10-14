String documentIdFromLocalData() => DateTime.now().toIso8601String();

class AppConstants {
  static const String paymentIntentPath =
      'https://api.stripe.com/v1/payment_intents';

  static const String publishableKey =
      'pk_test_51Q9oqE2NqCHVio1Q9pjUWNTBR6inWYYESOOK54dqKMMGNyZBYewBkpDgOL9Q7WanyaTBkjxOp3X5ReucPZauu5QZ00a3NWOvAs';
  static const String secretKey =
      'sk_test_51Q9oqE2NqCHVio1QqiQXvnqtkQv0DtDounbEW08sQjAArr2Ioc5L3Vg8xPKuPMMfbtEJEw1wR74abwAcsmTSY3oL00eli9cRjA';
}
