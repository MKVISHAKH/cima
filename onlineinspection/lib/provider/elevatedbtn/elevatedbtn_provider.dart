import 'package:onlineinspection/core/hook/hook.dart';

class ElevatedBtnProvider with ChangeNotifier {
  bool? _selectedVal = false;

  bool? get selectedVal => _selectedVal;

  void changeSelectedVal(bool? value) {
    _selectedVal = value;
    notifyListeners();
  }
}
