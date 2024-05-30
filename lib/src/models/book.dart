import 'dart:async';

import 'package:flutter/foundation.dart';

class Book {
  const Book({required this.pages});

  final List<String> pages;

  String get firstPage => pages.firstOrNull ?? '';

  Future<void> asyncAction() async {
    await Future.delayed(const Duration(seconds: 5));
    if (kDebugMode) print('End async');
  }

  String startAsyncAction() {
    final future = asyncAction();
    unawaited(future);
    return 'Start async';
  }
}
