import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class DrillEventList extends ChangeNotifier {
  List<DrillEvent> _events = [];
  List<DrillEvent> get events => _events;
  set events(val) {
    _events = val;
    notifyListeners();
  }

  List<String> _selectedEventToView = [];
  List<String> get selectedEventToView => _selectedEventToView;
  set selectedEventToView(val) {
    _selectedEventToView = val;
    notifyListeners();
  }

  List<DrillEvent> get eventsToDisplay {
    if (_selectedEventToView.isEmpty) {
      return _events;
    }
    List<DrillEvent> retVal = [];
    for (var element in _selectedEventToView) {
      retVal.addAll(_events.where((c) => c.name == element));
    }

    retVal.sort(((a, b) {
      return a.dateOfEvent.compareTo(b.dateOfEvent);
    }));
    return retVal;
  }

  List<MultiSelectItem<String>> getMultiSelectItems() {
    var eventNames = [];
    if (_events.isNotEmpty) {
      var seen = Set<String>();
      var getFromData =
          events.where((student) => seen.add(student.name)).toList();
      eventNames.addAll(getFromData.map((e) => e.name));
    }
    var result = eventNames.map((e) => MultiSelectItem<String>(e, e)).toList();
    return result;
  }

  void newEvent(DrillEvent newVal) {
    _events.add(newVal);
    notifyListeners();
  }

  void updateEvent(DrillEvent val) {
    var index = _events.indexWhere((element) => element.id == val.id);
    _events[index] = val;
    notifyListeners();
  }

  void deleteEvent(DrillEvent val) {
    _events.removeWhere((element) => element.id == val.id);
    notifyListeners();
  }

  void fetchEvents() {
    // ignore: todo
    // TODO: This should coming from the api
    _events = [
      DrillEvent()
        ..id = 'event 1'
        ..name = 'Fire Drill'
        ..description = 'This is a mandatory fire drill event for safety.'
        ..isDone = true
        ..dateOfEvent = DateTime(2021, 3, 1)
        ..icon = Icons.fire_extinguisher,
      DrillEvent()
        ..id = 'event 1'
        ..name = 'Fire Drill'
        ..description = 'This is a mandatory fire drill event for safety.'
        ..isDone = true
        ..dateOfEvent = DateTime(2022, 3, 1)
        ..icon = Icons.fire_extinguisher,
      DrillEvent()
        ..id = 'event 2'
        ..name = 'Flood Preparedness Drill'
        ..description =
            'This is a mandatory Flood Preparedness  drill event for safety.'
        ..isDone = false
        ..dateOfEvent = DateTime(2022, 9, 1)
        ..icon = Icons.water_drop,
      DrillEvent()
        ..id = 'event 3'
        ..name = 'Earthquake Drill'
        ..description = 'This is a mandatory Earthquake drill event for safety.'
        ..isDone = false
        ..dateOfEvent = DateTime(2022, 12, 1)
        ..icon = Icons.volcano,
      DrillEvent()
        ..id = 'event 4'
        ..name = 'Fire Drill'
        ..description = 'This is a mandatory fire drill event for safety.'
        ..isDone = false
        ..dateOfEvent = DateTime(2023, 3, 1)
        ..icon = Icons.fire_extinguisher,
      DrillEvent()
        ..id = 'event 5'
        ..name = 'Flood Preparedness Drill'
        ..description =
            'This is a mandatory Flood Preparedness  drill event for safety.'
        ..isDone = false
        ..dateOfEvent = DateTime(2023, 9, 1)
        ..icon = Icons.water_drop,
      DrillEvent()
        ..id = 'event 6'
        ..name = 'Earthquake Drill'
        ..description = 'This is a mandatory Earthquake drill event for safety.'
        ..isDone = false
        ..dateOfEvent = DateTime(2023, 12, 1)
        ..icon = Icons.volcano
    ];
    notifyListeners();
  }
}

class DrillEvent {
  late String id;
  late String name;
  late DateTime dateOfEvent;
  late String description;
  late bool isDone;
  late IconData icon;
  Color get getStatusColor => isDone ? Colors.green : Colors.orange;
  String get formattedDateOfEvent =>
      DateFormat('MMMM dd, yyyy').format(dateOfEvent);
  String get nameWithStatus => isDone ? "$name - complete" : "$name - upcoming";
}
