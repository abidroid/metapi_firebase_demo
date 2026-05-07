import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getFormattedDate(Timestamp timestamp)  {
  DateTime date = timestamp.toDate();
  return DateFormat('dd-MMM-yyyy hh:mm a').format(date);
}