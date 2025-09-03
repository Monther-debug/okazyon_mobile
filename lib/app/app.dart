import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/core/providers/theme_provider.dart';
import 'package:okazyon_mobile/core/theme/app_theme.dart';
import 'package:okazyon_mobile/features/auth/presentation/screens/login_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Okazyon',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const LoginScreen(),
    );
  }
}
