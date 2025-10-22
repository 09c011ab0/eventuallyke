import 'dart:convert';

import 'package:http/http.dart' as http;

class PaymentService {
  PaymentService({http.Client? httpClient}) : _http = httpClient ?? http.Client();

  final http.Client _http;

  Future<void> requestStkPush({required String phoneE164, required int amountKes, required String description}) async {
    final uri = Uri.parse(const String.fromEnvironment('FUNCTIONS_BASE_URL', defaultValue: 'http://localhost:5001/kenya-events-hub/us-central1'))
        .replace(path: '/darajaStkPush');
    final res = await _http.post(
      uri,
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'phone': phoneE164,
        'amount': amountKes,
        'description': description,
      }),
    );
    if (res.statusCode >= 300) {
      throw Exception('STK push failed: ${res.statusCode} ${res.body}');
    }
  }
}
