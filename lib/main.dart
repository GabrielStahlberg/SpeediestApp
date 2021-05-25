import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:speediest_app/screens/splash_screen.dart';
import 'package:speediest_app/store/home_store.dart';
import 'package:speediest_app/utils/contants.dart';
import 'package:speediest_app/utils/route_generator.dart';
import 'localization/app_localization.dart';
import 'utils/utils_impl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  GetIt getIt = GetIt.I;

  getIt.registerSingleton<HomeStore>(HomeStore());

  runApp(SpeediestApp());
}

final ThemeData defaultTheme = ThemeData(
  primaryColor: kPrimaryColor,
  accentColor: kPrimaryLightColor,
);

class SpeediestApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale newLocale) {
    _SpeediestAppState state =
    context.findAncestorStateOfType<_SpeediestAppState>();
    state.setLocale(newLocale);
  }

  @override
  _SpeediestAppState createState() => _SpeediestAppState();
}

class _SpeediestAppState extends State<SpeediestApp> {

  Locale _locale = Locale("pt", "BR");

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    UtilsImpl.getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: defaultTheme,
      onGenerateRoute: RouteGenerator.generateRoute,
      locale: _locale,
      supportedLocales: [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

