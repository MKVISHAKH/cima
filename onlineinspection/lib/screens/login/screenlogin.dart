
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String locationMessage='Current Location of the User';
  late String lat;
  late String long;
  final _usercontroller = TextEditingController();

  final _passcontroller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  bool passtoggle = true;
  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((value){
      lat='${value.latitude}';
      long='${value.longitude}';
      print('Latitude: $lat,Longitude: $long');
      setState(() {
        locationMessage='Latitude: $lat,Longitude: $long';
      });
      liveLocation();
    });
  }
  Future<Position>getCurrentLocation()async{
    bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }
    if(permission==LocationPermission.deniedForever){
      return Future.error('Location permissions are permanently denied,we cannot request permission');

    }
    return await Geolocator.getCurrentPosition();
  }
  void liveLocation(){
    LocationSettings locationSettings =const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position){
      lat=position.latitude.toString();
      long=position.longitude.toString();
      setState(() {
        locationMessage='Latitude: $lat,Longitude: $long';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(50),
            elevation: 3,
            shadowColor: Theme.of(context).colorScheme.primary,
            child: SizedBox(
              width: 300,
              height: 450,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Theme(
                        data: MyTheme.googleFormTheme,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20
                              ,
                            ),
                            Text('LOGIN',style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(
                              height: 50 ,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 5),
                                child: TextFormField(
                                    controller: _usercontroller,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter valid Username";
                                      } else if (value.contains('.') ||
                                          value.contains("-") ||
                                          value.contains(" ") ||
                                          value.contains(",")) {
                                        return "Enter valid Username";
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:95),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Username?',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                child: TextFormField(
                                    controller: _passcontroller,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      prefixIcon: Theme(
                                        data: MyTheme.appIconTheme,
                                        child: const Icon(
                                          Icons.lock,
                                        ),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            passtoggle = !passtoggle;
                                          });
                                        },
                                        child: Theme(
                                          data: MyTheme.appIconTheme,
                                          child: Icon(
                                            passtoggle
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                      ),
                                    ),
                                    obscureText: passtoggle,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter password';
                                      }
                                      // else if (_passcontroller.text.length <
                                      //     8) {
                                      //   return 'Please enter atleast 8 characters';
                                      // }
                                      else if (value.contains(' ')) {
                                      }
                                      // else if (_passcontroller.text.length < 8) {
                                      //   return 'Please enter atleast 8 characters';
                                      // }
                                      else if (value.contains(' ')) {
                                        return 'Remove space from password';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:97),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 35,
                              width: 200,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.black54, Colors.black87],
                                ),
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Theme(
                                data: MyTheme.buttonStyleTheme,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      Navigator.pushReplacement(
                                      _scaffoldKey.currentContext!, Approutes().homescreen);
                                    }
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                            
                            
                            const SizedBox(height: 10),
                            Consumer<LoadingProvider>(
                                builder: (context, loadingProvider, child) {
                              return loadingProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 2, 128, 6),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}