import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/provider/additional_info/additional_info_provider.dart';

const savekeyname = 'UserLoggedIn';
const savesocinfo = '_userSocIn';
const savedeviceinfo = '_userDeviceIn';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //MyApp({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late final SessionTimer sessionTimer;

  MyApp({super.key}) {
    sessionTimer = SessionTimer(navigatorKey);
    sessionTimer.startTimer();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(providers: [
        ChangeNotifierProvider<LoadingProvider>(
            create: (context) => LoadingProvider()),
        ChangeNotifierProvider<ElevatedBtnProvider>(
            create: (context) => ElevatedBtnProvider()),
        ChangeNotifierProvider<LocationMatchProvider>(
            create: (context) => LocationMatchProvider()),
        ChangeNotifierProvider<AdditionalInfoProvider>(
            create: (context) => AdditionalInfoProvider()),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
          builder: (context, child) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'CIA',
              themeMode: themeProvider.themeMode,
              theme: themeProvider.lightScheme,
              darkTheme: themeProvider.darkScheme,
              home: const ScreenSplash(),
            );
          },
        ),
      ]);
}
