import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'exception.dart';
import 'models/event_data.dart';
import 'options.dart';

class Stape {
  final StapeOptions options;

  http.Client _client;

  factory Stape({
    required String domain,
    String requestPath = '/data',
    bool richsstsse = false,
    int protocolVersion = 2,
  }) {
    return Stape.withOption(
      StapeOptions(
        domain: domain,
        requestPath: requestPath,
        richsstsse: richsstsse,
        protocolVersion: protocolVersion,
      ),
    );
  }

  Stape.withOption(this.options) : _client = http.Client() {
    validateOptions();
  }

  @visibleForTesting
  setHttpClient(http.Client client) {
    _client = client;
  }

  Future<dynamic> sendEvent(String eventName, Map<String, dynamic> eventData) async {
    return sendEventData(eventName, EventData.fromJson(eventData));
  }

  Future<dynamic> sendEventData(String eventName, EventData eventData) async {
    try {
      Uri url = Uri.parse('${options.domain}${options.requestPath}');

      url = url.replace(
        queryParameters: {
          'v': options.protocolVersion?.toString(),
          'event_name': Uri.encodeComponent(eventName),
          if (options.richsstsse == true) 'richsstsse': '',
        },
      );

      final postData = {
        ...eventData.toJson(),
        'event_name': eventName,
        'v': options.protocolVersion,
      };

      final response = await _client.post(
        url,
        body: json.encode(postData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw StapeException({
          'status': response.statusCode,
          'statusText': response.reasonPhrase,
          'error': response.body,
        });
      }

      var body;

      try {
        body = json.decode(response.body);
      } catch (e) {
        body = response.body;
      }

      return body;
    } on StapeException catch (_) {
      rethrow;
    } catch (e) {
      throw StapeException('Error sending event data: $e');
    }
  }

  void validateOptions() {
    if (!options.domain.startsWith('https://') || options.domain.endsWith('/')) {
      throw StapeException('You did not fill in the variable domain correctly. Example: https://gtm.stape.io');
    }
    if (options.requestPath?.startsWith('/') != true) {
      throw StapeException('You did not fill in the variable requestPath correctly. Example: /');
    }
  }
}
