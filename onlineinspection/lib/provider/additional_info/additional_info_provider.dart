import 'package:flutter/material.dart';
import 'package:onlineinspection/model/query/questions/questionresp/additional_info.dart';

class AdditionalInfoProvider with ChangeNotifier {
  List<AdditionalInfo> _selectedInfo = [];

  List<AdditionalInfo> get selectedInfo => _selectedInfo;

  void updateSelectedInfo(List<AdditionalInfo> info) {
    _selectedInfo = info;
    notifyListeners();
  }

  void addMemberField() {
    _selectedInfo.add(
      AdditionalInfo(name: 'mname', label: 'Member Name'),
    );
    notifyListeners();
  }

  void removeMemberField(int index) {
    _selectedInfo.removeAt(index);
    notifyListeners();
  }

  void clearSelectedInfo() {
    _selectedInfo = [];
    notifyListeners();
  }
}
