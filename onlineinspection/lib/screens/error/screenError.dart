import 'package:onlineinspection/core/hook/hook.dart';

class ScreenError extends StatefulWidget {
  const ScreenError({super.key});

  @override
  State<ScreenError> createState() => _ScreenErrorState();
}

class _ScreenErrorState extends State<ScreenError> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(key: _scaffoldKey, children: [
      // const Backgroundsplash(),
      Scaffold(
        backgroundColor: const Color(0xff98c1d9),
        body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage("assets/errror/alekseyvanin200701168.jpg"),
                  ),
                  //Text("Loading")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Something Went Wrong",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Theme(
                  data: MyTheme.buttonStyleTheme,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context, Approutes().screenSplash);
                    },
                    child: Text(
                      'RETRY',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
