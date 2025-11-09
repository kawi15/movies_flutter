import 'package:flutter_test/flutter_test.dart';
import 'package:movies/core/utils/release_date_formatter.dart';

void main() {
  group('formatReleaseDate', () {
    test('returns formatted date for valid input', () {
      final result = formatReleaseDate('1998-02-12');
      expect(result, '12 February 1998');
    });

    test('returns "No release date" for null input', () {
      final result = formatReleaseDate(null);
      expect(result, 'No release date');
    });

    test('returns "No release date" for empty input', () {
      final result = formatReleaseDate('');
      expect(result, 'No release date');
    });

    test('returns original string for invalid date', () {
      final result = formatReleaseDate('not-a-date');
      expect(result, 'not-a-date');
    });
  });
}
