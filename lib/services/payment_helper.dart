import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shoes/models/orders/orders_req.dart';
import 'package:shoes/services/config.dart';

class PaymentHelper {
  static var client = https.Client();

  Future<String> payment(Order model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.paymentBaseUrl, Config.paymentUrl);

    var response = await client.post(url, 
    headers: requestHeaders, body: jsonEncode(model.toJson())
    );
      if (response.statusCode == 200) {
      var payment = jsonDecode(response.body);
      return payment['url'];
    } else {
      return 'failed';
    }
  }
}
