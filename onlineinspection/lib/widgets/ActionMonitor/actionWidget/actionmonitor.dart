import 'package:onlineinspection/core/hook/hook.dart';

class ActivityMonitor extends StatelessWidget {
  final Widget child;
  final SessionTimer sessionTimer;

  const ActivityMonitor(
      {super.key, required this.child, required this.sessionTimer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sessionTimer.userActivityDetected,
      onPanDown: sessionTimer.userActivityDetected,
      onScaleStart: sessionTimer.userActivityDetected,
      child: child,
    );
  }
}
