import 'package:onlineinspection/core/hook/hook.dart';

const savekeyname = 'UserLoggedIn';
const savesocinfo = '_userSocIn';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(providers: [
        ChangeNotifierProvider<LoadingProvider>(
            create: (context) => LoadingProvider()),
        ChangeNotifierProvider<ElevatedBtnProvider>(
            create: (context) => ElevatedBtnProvider()),
        ChangeNotifierProvider<LocationMatchProvider>(
            create: (context) => LocationMatchProvider()),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
          builder: (context, child) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
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
