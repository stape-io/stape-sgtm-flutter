import 'package:flutter_test/flutter_test.dart';
import 'package:stape_sdk/src/transformations.dart';

void main() {
  group('Transformations', () {
    group('base64', () {
      test('should encode a string to base64', () {
        const input = 'Hello, World!';
        const expectedOutput = 'SGVsbG8sIFdvcmxkIQ==';
        expect(base64Encode(input), expectedOutput);
      });
    });

    group('trim', () {
      test('should remove leading and trailing whitespace', () {
        const input = '   Trim me   ';
        const expectedOutput = 'Trim me';
        expect(trim(input), expectedOutput);
      });
    });

    group('sha256base64', () {
      test('should compute SHA-256 and return base64 encoded value', () {
        const input = 'Hash me';
        const expectedOutput = '6yAa9arw1gYp09KmHkZs/A/ttRet2DHsrFI14dqpY9Y=';
        expect(sha256base64Encode(input), expectedOutput);
      });
    });

    group('sha256hex', () {
      test('should compute SHA-256 and return hex encoded value', () {
        const input = 'Hash me';
        const expectedOutput = 'eb201af5aaf0d60629d3d2a61e466cfc0fedb517add831ecac5235e1daa963d6';
        expect(sha256Encode(input), expectedOutput);
      });
    });

    group('md5', () {
      test('should compute MD5 hash', () {
        const input = 'Hash me';
        const expectedOutput = '17b31dce96b9d6c6d0a6ba95f47796fb';
        expect(md5Encode(input), expectedOutput);
      });
    });

    group('toLowerCase', () {
      test('should convert a string to lowercase', () {
        const input = 'Convert Me To Lowercase';
        const expectedOutput = 'convert me to lowercase';
        expect(toLowerCase(input), expectedOutput);
      });
    });
  });
}
