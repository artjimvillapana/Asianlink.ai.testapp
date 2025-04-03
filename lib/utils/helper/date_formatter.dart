import 'package:intl/intl.dart';

String formatDate(String dateString, String inputFormat, String outputFormat) {
  try {
    DateTime date = DateFormat(inputFormat).parse(dateString);

    String formattedDate = DateFormat(outputFormat).format(date);

    return formattedDate;
  } catch (e) {
    return "Invalid date or format";
  }
}
