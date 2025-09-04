import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider<Locale?>((ref) => null);

void setArabic(WidgetRef ref) =>
    ref.read(localeProvider.notifier).state = const Locale('ar');
void setEnglish(WidgetRef ref) =>
    ref.read(localeProvider.notifier).state = const Locale('en');
void setSystemLocale(WidgetRef ref) =>
    ref.read(localeProvider.notifier).state = null;
