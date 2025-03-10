import 'package:onlineinspection/core/hook/hook.dart';

class Navbar extends StatefulWidget {
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
  String? usrNm;
  int? pen;

  @override
  void initState() {
    super.initState();
    buildversion();
  }

  void buildversion() async {
    final value = await SharedPrefManager.instance.getdeviceinfo();
    final val = await SharedPrefManager.instance.getSharedData();
    usrNm = val!.name;
    pen = val.pen;

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
              accountName: Text(
                '$usrNm',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
                textScaler: TextScaler.noScaling,
              ),
              accountEmail: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PEN No: $pen',
                    style: Theme.of(context).textTheme.labelMedium,
                    textScaler: TextScaler.noScaling,
                  ),
                  Text('Version:$version',
                    style: Theme.of(context).textTheme.labelMedium,
                    textScaler: TextScaler.noScaling,),
                ],
              ),
              // currentAccountPicture: CircleAvatar(
              //   child: ClipOval(
              //     child: Image.asset(
              //       'assets/splash/2527291.jpg',
              //       width: 90,
              //       height: 90,
              //       fit: BoxFit.cover, //fit image in circle
              //     ),
              //   ),
              // ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/splash/bg.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              // BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //         colors: [
              //       Theme.of(context).colorScheme.secondary,
              //       Theme.of(context).colorScheme.primary
              //     ])),
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
            // ListTile(
            //     leading: const Icon(
            //       Icons.mobile_friendly,
            //     ),
            //     title: Text(
            //       "Change Mobile Number",
            //       style: Theme.of(context).textTheme.displaySmall,
            //     ),
            //     onTap: () {
            //       Navigator.push(context, Approutes().changeMobScreen);
            //     }),
            ListTile(
                leading: const Icon(
                  Icons.location_on_sharp,
                  size: 20,
                  color: Colors.white,
                ),
                title: Text(
                  "Location Mapping",
                  style: Theme.of(context).textTheme.displaySmall,
                  textScaler: TextScaler.noScaling,
                ),
                onTap: () {
                  Livelocationfun.instance.locationUpdtLst(context);
                  Navigator.push(context, Approutes().addgeolocation);
                }),
            ListTile(
                leading: const Icon(
                  Icons.lock, size: 20, color: Colors.white,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.displaySmall,
                  textScaler: TextScaler.noScaling,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().changepswrdScreen);
                }),
            const Divider(
              thickness: .4,
            ),
            ListTile(
                leading: const Icon(
                  Icons.logout_outlined, size: 20, color: Colors.white,
                  //color: Appcolors.labelclr,
                ),
                title: Text(
                  "Sign Out",
                  style: Theme.of(context).textTheme.displaySmall,
                  textScaler: TextScaler.noScaling,
                ),
                onTap: () {
                  warningBox(context);
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
Future warningBox(BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            title: Center(
                child: Text("Do You want to Sign Out?",
                    style: Theme.of(context).textTheme.titleSmall)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('NO',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                     signout(context);
                },
                child: Text('YES',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ));
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
