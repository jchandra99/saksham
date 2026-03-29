import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../database/db_helper.dart';
import '../models/monitoring_form_model.dart';
import '../models/house_data_model.dart';

class FormProvider extends ChangeNotifier {
  final DbHelper dbHelper;
  List<MonitoringSession> sessions = [];
  MonitoringSession? selectedSession;
  List<HouseMonitoringData> houses = [];

  FormProvider({required this.dbHelper});

  Future<void> loadSessions() async {
    sessions = await dbHelper.getAllSessions();
    if (sessions.isEmpty) {
      await dbHelper.seedSampleData();
      sessions = await dbHelper.getAllSessions();
    }
    notifyListeners();
  }

  Future<void> selectSession(String id) async {
    selectedSession = sessions.firstWhere((session) => session.id == id, orElse: () => MonitoringSession(
      id: id,
      createdAt: '',
      updatedAt: '',
    ));
    houses = await dbHelper.getHousesForSession(id);
    if (houses.isEmpty) {
      houses = List.generate(5, (index) {
        return HouseMonitoringData(
          id: const Uuid().v4(),
          sessionId: id,
          houseNumber: index + 1,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );
      });
    }
    notifyListeners();
  }

  Future<void> createNewSession() async {
    final id = const Uuid().v4();
    selectedSession = MonitoringSession(
      id: id,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
    houses = List.generate(5, (index) {
      return HouseMonitoringData(
        id: const Uuid().v4(),
        sessionId: id,
        houseNumber: index + 1,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );
    });
    notifyListeners();
  }

  Future<void> saveCurrentSession() async {
    if (selectedSession == null) return;
    selectedSession!.updatedAt = DateTime.now().toIso8601String();
    await dbHelper.insertSession(selectedSession!);
    for (final house in houses) {
      await dbHelper.insertHouse(house);
    }
    await loadSessions();
  }

  Future<void> deleteSession(String id) async {
    await dbHelper.deleteSession(id);
    await loadSessions();
  }

  void updateHouse(HouseMonitoringData house) {
    final index = houses.indexWhere((h) => h.id == house.id);
    if (index != -1) {
      houses[index] = house;
      notifyListeners();
    }
  }

  void copyFromHouse1(int targetIndex) {
    if (houses.isEmpty || targetIndex <= 0 || houses.length <= targetIndex) return;
    final source = houses[0];
    houses[targetIndex] = source.copyWith(
      id: houses[targetIndex].id,
      houseNumber: targetIndex + 1,
      sessionId: houses[targetIndex].sessionId,
    );
    notifyListeners();
  }

  int get totalForms => sessions.length;

  int get pendingSync => sessions.where((s) => s.synced == 0).length;

  int get todaysForms {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return sessions.where((s) => s.monitoringDate == today).length;
  }
}
