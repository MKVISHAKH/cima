import 'package:onlineinspection/core/hook/hook.dart';

class Navbar extends StatefulWidget {
  //final int? category;
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = '';
  String brname = '';
  bool isVisible = true;
  String? version;
  @override
  void initState() {
    super.initState();
    buildversion();
  }

  void buildversion() async {
    final value = await SharedPrefManager.instance.getdeviceinfo();

    final devversion = value.appversion;
    final devicever = devversion!.split('+');
    final versionval = devicever[0];

    setState(() {
      version = versionval;
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Screenhome(),
      ),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
      },
      child: Drawer(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'C I A',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              accountEmail: Text(
                'Version:$version',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/splash/2527291.jpg',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover, //fit image in circle
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary
                  ])),
            ),
            // ListTile(
            //     leading: const Icon(
            //       Icons.report,
            //       color: Color(0xff13bc91),
            //     ),
            //     title: Text(
            //       "Inspection Report",
            //       style: Theme.of(context).textTheme.bodyMedium,
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().reportScreen);
            //     }),
            ListTile(
                leading: const Icon(
                  Icons.mobile_friendly,
                ),
                title: Text(
                  "Change Mobile Number",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().changeMobScreen);
                }),
            ListTile(
                leading: const Icon(
                  Icons.lock,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().changepswrdScreen);
                }),
            const Divider(),
            ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Sign Out",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                onTap: () {
                  signout(context);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void signout(BuildContext ctx) async {
    final sharedprf = await SharedPreferences.getInstance();
    await sharedprf.remove(savekeyname);
    Navigator.of(_scaffoldKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const ScreenLogin(),
        ),
        (Route<dynamic> route) => false);
  }
}
