import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeUtil {
  String formatDate(DateTime? inputDateTime) {
    if (inputDateTime == null) {
      return "";
    }
    return DateFormat('dd MMMM yyyy').format(inputDateTime);
  }

  String forMateTime(DateTime? inputDateTime) {
    if (inputDateTime == null) {
      return "";
    }
    // DateTime _time = DateTime.fromMillisecondsSinceEpoch(incomingTime);
    return DateFormat('HH:mm').format(inputDateTime);
  }

  String getTimeAgo(int? incomingTime) {
    if (incomingTime == null) {
      return "";
    }
    DateTime _time = DateTime.fromMillisecondsSinceEpoch(incomingTime);
    return timeago.format(_time);
  }
}
