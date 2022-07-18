import 'package:flutter/material.dart';

class DrillTypeConfig extends ChangeNotifier {
  List<DrillType> drillTypes = [];

  Future getDrillTypes() async {
    drillTypes = [
      DrillType()
        ..name = 'Earthquake Drill'
        ..isExpanded = false,
      DrillType()
        ..name = 'Fire Drill'
        ..isExpanded = false,
      DrillType()
        ..name = 'Flood Drill'
        ..isExpanded = false,
      DrillType()
        ..name = 'Emergency Drill'
        ..isExpanded = false
    ];
    print('Drill Types fetch...');
    return drillTypes;
  }

  void addDrillTypes(val) {
    drillTypes.add(val);
    notifyListeners();
  }

  void removeDrillTypes(val) {
    drillTypes.removeWhere((element) => element == val);
    notifyListeners();
  }
}

class DrillType {
  String _name = '';
  String get name => _name;
  set name(val) {
    _name = val;
  }

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;
  set isExpanded(val) {
    _isExpanded = val;
  }
}
