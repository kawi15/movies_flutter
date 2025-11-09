import 'package:intl/intl.dart';

/// Format date to 'd MMMM yyyy'
String formatReleaseDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return 'No release date';
  try {
    final date = DateTime.parse(dateStr);
    return DateFormat('d MMMM yyyy', 'en_US').format(date);
  } catch (_) {
    return dateStr;
  }
}