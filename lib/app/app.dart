import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/core/theme/theme.dart';
import 'package:okazyon_mobile/features/auth/presentation/screens/login_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Okazyon',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
