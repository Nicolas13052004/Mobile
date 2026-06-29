import 'package:intl/intl.dart';

class Helpers {

  // Format date (API → UI)
  static String formatDate(String date) {

    final parsed = DateTime.parse(date);

    return DateFormat('dd/MM/yyyy')
        .format(parsed);
  }

  // Format heure
  static String formatTime(String date) {

    final parsed = DateTime.parse(date);

    return DateFormat('HH:mm')
        .format(parsed);
  }

  // Capitalize text
  static String capitalize(String text) {

    if (text.isEmpty) return text;

    return text[0].toUpperCase() +
        text.substring(1);
  }

  // Loading simple check
  static bool isEmpty(dynamic value) {

    return value == null ||
        value.toString().isEmpty;
  }
}