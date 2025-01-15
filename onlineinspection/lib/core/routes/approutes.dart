import 'package:onlineinspection/core/hook/hook.dart';

class Approutes {
  PageTransition loginscreen = PageTransition(
    child: const ScreenLogin(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition homescreen = PageTransition(
    child: const Screenhome(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition assignedscreen = PageTransition(
    child: const ScreenAssigned(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition forgotusrScreen = PageTransition(
    child: const ScreenForgotUser(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition forgotpswrdScreen = PageTransition(
    child: const ScreenForgotPswrd(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition changepswrdScreen = PageTransition(
    child: const ScreenChangePswrd(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition changeMobScreen = PageTransition(
    child: const ScreenChangeMobNo(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition basicInfoScreen = PageTransition(
    child: const ScreenBasicInfo(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition scheduleScreen = PageTransition(
    child: const ScreenScheduled(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition cmpltRprtScreen = PageTransition(
    child: const ScreenCmpltdRprt(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition schdleTabScreen = PageTransition(
    child: const ScreenScheduled(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition errorScreen = PageTransition(
    child: const ScreenError(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition screenSplash = PageTransition(
    child: const ScreenSplash(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition screenschdlReq = PageTransition(
    child: const ScreenSchdlReq(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition screensActionRprt = PageTransition(
    child: const ScreenActionRprt(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  PageTransition addgeolocation = PageTransition(
    child: const ScreenAddLocation(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
}
