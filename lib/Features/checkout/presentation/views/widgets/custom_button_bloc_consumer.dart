import 'dart:developer';

import 'package:checkout_payment_ui/Features/checkout/data/models/amount_model/amount_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/amount_model/details.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/item_list_model/item.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/item_list_model/item_list_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment_ui/Features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:checkout_payment_ui/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:checkout_payment_ui/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ThankYouView();
              },
            ),
          );
        }
        if (state is PaymentFailure) {
          log(state.errmessage);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errmessage),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            // PaymentIntentInputModel paymentIntentInputModel =
            //     PaymentIntentInputModel(
            //   amount: '500',
            //   currency: 'USD',
            //   customerId: 'cus_RZeSnsCf98vBOs',
            // );
            // context.read<PaymentCubit>().makePayment(
            //       paymentIntentInputModel: paymentIntentInputModel,
            //     );
            var amount = AmountModel(
              total: '100',
              currency: 'USD',
              details:
                  Details(subtotal: '100', shipping: '0', shippingDiscount: 0),
            );
            List<OrderItemModel> orders = [
              OrderItemModel(
                name: 'Apple',
                quantity: 4,
                price: '10',
                currency: 'USD',
              ),
              OrderItemModel(
                name: 'Pineapple',
                quantity: 5,
                price: '12',
                currency: 'USD',
              ),
            ];
            var itemList = ItemListModel(orders: orders);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckoutView(
                sandboxMode: true,
                clientId:
                    "AeJpgg0Vokrqu91ggrwXqusxS7E5XHRVGfXgCbqTE2LUJuU4ajf0r4ET0hY6Nu27dKqbK9XQn6SK5uox",
                secretKey:
                    "ELpyv3m4w1AZeRWZLNhIa3jFxNWJki1CX71jdMJodlBKcbC43I4NOedGYooQRmsafSQje9rh7WRxcWaP",
                transactions: [
                  {
                    "amount": amount.toJson(),
                    "description": "The payment transaction description.",
                    "item_list": itemList.toJson(),
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
          text: 'Continue',
          isloading: state is PaymentLoading ? true : false,
        );
      },
    );
  }
}
