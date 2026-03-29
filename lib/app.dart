import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants/app_theme.dart';
import 'database/db_helper.dart';
import 'providers/auth_provider.dart';
import 'providers/form_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/form_list_screen.dart';
import 'screens/monitoring_form_screen.dart';
import 'screens/pdf_preview_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(dbHelper: DbHelper.instance)),
        ChangeNotifierProvider(create: (_) => FormProvider(dbHelper: DbHelper.instance)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'दस्तक मॉनीटरिंग',
        theme: AppTheme.theme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('hi'), Locale('en')],
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          '/login': (_) => const LoginScreen(),
          '/dashboard': (_) => const DashboardScreen(),
          '/forms': (_) => const FormListScreen(),
          '/monitoring': (_) => const MonitoringFormScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/pdf') {
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(builder: (_) => PdfPreviewScreen(sessionId: args?['sessionId'] as String));
          }
          return null;
        },
      ),
    );
  }
}
