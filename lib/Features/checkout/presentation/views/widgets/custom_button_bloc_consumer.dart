import 'dart:developer';

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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckoutView(
                sandboxMode: true,
                clientId: "",
                secretKey: "",
                transactions: const [
                  {
                    "amount": {
                      "total": '70',
                      "currency": "USD",
                      "details": {
                        "subtotal": '70',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "USD"
                        }
                      ],

                      // shipping address is not required though
                      //   "shipping_address": {
                      //     "recipient_name": "tharwat",
                      //     "line1": "Alexandria",
                      //     "line2": "",
                      //     "city": "Alexandria",
                      //     "country_code": "EG",
                      //     "postal_code": "21505",
                      //     "phone": "+00000000",
                      //     "state": "Alexandria"
                      //  },
                    }
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
