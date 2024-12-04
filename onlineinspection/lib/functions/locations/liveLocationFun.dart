
import 'package:onlineinspection/core/hook/hook.dart';

class Livelocationfun{
  Livelocationfun._internal();
  
  static Livelocationfun instance = Livelocationfun._internal();
  Livelocationfun factory() {
    return instance;
  }

  final StreamController<Position> _positionStreamController = StreamController.broadcast();
  Stream<Position> get positionStream => _positionStreamController.stream;
  
  Timer? _locationTimer;

  void startTracking() {
    _locationTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        try {
          Position position = await Geolocator.getCurrentPosition();
          _positionStreamController.add(position);
        } catch (e) {
          _positionStreamController.addError(e);
        }
      }
    });
  }

  void stopTracking() {
    _locationTimer?.cancel();
    _positionStreamController.close();
  }
}