import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repo/checkout_repo.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    final data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold(
      (l) => emit(PaymentFailure(errmessage: l.toString())),
      (r) => emit(PaymentSuccess()),
    );
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
