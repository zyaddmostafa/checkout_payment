import 'package:checkout_payment_ui/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  Stripe.publishableKey =
      'pk_test_51QfqzNDRhw0UMOsFfP7u3bES8wShNt0vgMB3Ofseiyf0btonGjPVDWr95eUyXJuHcsXEXpGYQnzajrYxXiEsBSW700zyfd5Uu6';
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}


// paymentIntentObject =>  create payment intent (amount, currency) is required
// init payment sheet (paymentsheetClientSecret)
// present payment sheet ()