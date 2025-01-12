import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repo/checkout_repo.dart';
import 'package:checkout_payment_ui/core/error/failure.dart';
import 'package:checkout_payment_ui/core/utils/stripe_service.dart';
import 'package:dartz/dartz.dart';

class CheckoutRepoIml implements CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);

      return right(null);
    } catch (e) {
      return left(ServerFailure(errmessnage: e.toString()));
    }
  }
}
