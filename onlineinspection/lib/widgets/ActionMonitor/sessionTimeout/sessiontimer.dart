import 'package:onlineinspection/core/hook/hook.dart';

class SessionTimer {
  Timer? _timer;
  final GlobalKey<NavigatorState> navigatorKey;

  SessionTimer(this.navigatorKey);

  void startTimer() {
    _timer = Timer.periodic(const Duration(hours: 2), (_) {
      timedOut();
    });
  }

  void userActivityDetected([_]) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      startTimer();
    }
  }

  Future<void> timedOut() async {
    _timer?.cancel();
    if (navigatorKey.currentContext != null) {
      await showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primaryFixed,
          title: Text('Alert', style: Theme.of(context).textTheme.bodyLarge),
          content: const Text(
              'Sorry, but you have been logged out due to inactivity...'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                signout(navigatorKey.currentContext!);
              },
              child: Text('OK', style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      );
    }
  }

  void signout(BuildContext ctx) async {
    final sharedprf = await SharedPreferences.getInstance();
    await sharedprf.remove(savekeyname);
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const ScreenLogin(),
        ),
        (Route<dynamic> route) => false);
  }
}
