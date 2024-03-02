import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:stape_sdk/stape_sdk.dart';

void main() {
  group('Stape', () {
    final defaultEventData = EventData(ipOverride: '79.144.69.69'); // Ajuste conforme a estrutura de EventData.

    Stape createTestInstance({
      String? domain,
      String? requestPath,
      bool? richsstsse,
      int? protocolVersion,
      Future<http.Response> Function(http.Request req)? mockResolvedValue,
    }) {
      final instance = Stape(
        domain: domain ?? 'https://example.com',
        requestPath: requestPath ?? '/data',
        richsstsse: richsstsse ?? false,
        protocolVersion: protocolVersion ?? 2,
      );

      if (mockResolvedValue != null) {
        instance.setHttpClient(
          MockClient(mockResolvedValue),
        );
      }

      return instance;
    }

    test('should send event data and return the response data', () async {
      final instance = createTestInstance(
        mockResolvedValue: (req) async {
          return http.Response('{ "data": "response data" }', 200);
        },
      );

      var response = await instance.sendEventData('event', defaultEventData);

      expect(response, contains('data'));
      expect(response['data'], 'response data');
    });

    test('should send event data with richsstsse and return the response data', () async {
      final instance = createTestInstance(
        richsstsse: true,
        mockResolvedValue: (req) async {
          return http.Response('{ "data": "response data" }', 200);
        },
      );

      var response = await instance.sendEventData('event', defaultEventData);

      expect(response, contains('data'));
      expect(response['data'], 'response data');
    });

    test('should send event data with richsstsse and return the response data', () async {
      final response = http.Response('Error data', 500, reasonPhrase: 'Internal Server Error');

      final instance = createTestInstance(
        mockResolvedValue: (req) async {
          return response;
        },
      );

      expectLater(
        () => instance.sendEventData('event', defaultEventData),
        throwsA(
          const TypeMatcher<StapeException>()
              .having((e) => e.details, 'details', isMap)
              .having((e) => e.details['status'], 'details.status', equals(response.statusCode))
              .having((e) => e.details['statusText'], 'details.statusText', equals(response.reasonPhrase))
              .having((e) => e.details['error'], 'details.error', equals(response.body)),
        ),
      );
    });

    test('should throw StapeError with empty details', () async {
      final instance = createTestInstance(
        mockResolvedValue: (req) async {
          throw Exception();
        },
      );

      expectLater(
        () => instance.sendEventData('event', defaultEventData),
        throwsA(const TypeMatcher<StapeException>()),
      );
    });

    test('should validate configuration', () async {
      expect(
        () {
          Stape(
            domain: 'invalid-domain',
            requestPath: '/data',
          );
        },
        throwsA(
          const TypeMatcher<StapeException>().having(
            (e) => e.details,
            'details',
            contains('You did not fill in the variable domain'),
          ),
        ),
      );

      expect(
        () {
          Stape(
            domain: 'https://example.com',
            requestPath: 'invalid-path',
          );
        },
        throwsA(
          const TypeMatcher<StapeException>().having(
            (e) => e.details,
            'details',
            contains('You did not fill in the variable requestPath'),
          ),
        ),
      );
    });
  });
}
