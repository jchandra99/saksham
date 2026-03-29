import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/api_service.dart';
import 'db_helper.dart';

class SyncService {
  final DbHelper dbHelper;
  final ApiService apiService;

  SyncService({required this.dbHelper, required this.apiService});

  Future<bool> hasInternet() async {
    final status = await Connectivity().checkConnectivity();
    return status != ConnectivityResult.none;
  }

  Future<Map<String, dynamic>> syncPending() async {
    final online = await hasInternet();
    if (!online) {
      return {'status': 'offline'};
    }
    final sessions = await dbHelper.getUnsyncedSessions();
    final houses = await dbHelper.getUnsyncedHouses();
    if (sessions.isEmpty && houses.isEmpty) {
      return {'status': 'success', 'synced_count': 0};
    }
    final payload = {
      'sessions': sessions.map((s) => s.toMap()).toList(),
      'houses': houses.map((h) => h.toMap()).toList(),
    };
    final response = await apiService.syncMonitoring(payload);
    if (response['status'] == 'success') {
      for (final session in sessions) {
        await dbHelper.markSessionSynced(session.id);
      }
      for (final house in houses) {
        await dbHelper.markHouseSynced(house.id);
      }
    }
    return response;
  }
}
