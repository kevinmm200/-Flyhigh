// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../constants.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: correct,
      content: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));
}
