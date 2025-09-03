import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/core/providers/theme_provider.dart';
import 'package:okazyon_mobile/core/providers/locale_provider.dart';
import 'package:okazyon_mobile/core/theme/theme.dart' as app_theme;
import 'package:okazyon_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppLocalizations.of(context)?.appTitle ?? 'Okazyon',
  theme: app_theme.AppTheme.lightTheme,
  darkTheme: app_theme.AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Use Poppins for LTR and Almarai for RTL
      builder: (context, child) {
        final isRTL = Directionality.of(context) == TextDirection.rtl;
        final baseTheme = isRTL ? Theme.of(context).copyWith(
          textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
        ) : Theme.of(context).copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        );
        return Theme(data: baseTheme, child: child!);
      },
      home: const LoginScreen(),
    );
  }
}
