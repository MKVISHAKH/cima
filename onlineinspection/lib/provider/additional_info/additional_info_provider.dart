import 'package:onlineinspection/core/hook/hook.dart';

class AdditionalInfoProvider with ChangeNotifier {
  List<AdditionalInfo> _selectedInfo = [];

  List<AdditionalInfo> get selectedInfo => _selectedInfo;

  void updateSelectedInfo(List<AdditionalInfo> info) {
    _selectedInfo = info;
    notifyListeners();
  }

  void clearSelectedInfo() {
    _selectedInfo = [];
    notifyListeners();
  }

  //  bool hasMandatoryFields() {
  //   return selectedInfo.any((field) => field.isMandatory);
  // }
}
