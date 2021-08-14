import 'dart:convert';

import 'package:faturas_base/payment-options/model/payment_option.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class PaymentOptionsRestService {
  Future<List<PaymentOption>> fetchPaymentOptions() async {
    final url = Uri.parse(
        'https://dreamy-allen-2e1b47.netlify.app/payment-options.json');

    final Response response = await get(url).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final Iterable l = json.decode(response.body)['options']['installments'];
      return List<PaymentOption>.from(
          l.map((model) => PaymentOption.fromJson(model)));
    } else {
      throw Exception('Falha ao carregar opções de pagamento.');
    }
  }
}
