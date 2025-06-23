import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatTimestamp(dynamic timestamp, DateTime now) {
  if (timestamp == null) return '';

  final messageTime = timestamp is int
      ? DateTime.fromMicrosecondsSinceEpoch(timestamp)
      : (timestamp is Timestamp
            ? timestamp.toDate()
            : DateTime.tryParse(timestamp.toString()) ?? now);

  final diff = now.difference(messageTime);

  // final formattedDate = DateFormat(
  //   'MMM d, y',
  // ).format(messageTime);
  final formattedTime = DateFormat('hh:mm a').format(messageTime);
  // final fullDateTime = '$formattedDate ($formattedTime)';

  // Force negative diffs to 0 (just now)
  if (diff.isNegative) return 'Just now';

  if (diff.inSeconds < 60) return '${diff.inSeconds} seconds ago';
  if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
  if (diff.inHours == 1 && diff.inHours < 24) {
    return formattedTime;
  }
  if (diff.inHours < 24) return '${diff.inHours} hours ago';

  if (diff.inDays == 1) return 'Yesterday';
  if (diff.inDays <= 7) return '${diff.inDays} days ago';
  if (now.year == messageTime.year) {
    return '${messageTime.day}/${messageTime.month}';
  }

  return '${messageTime.day}/${messageTime.month}/${messageTime.year}';
}
