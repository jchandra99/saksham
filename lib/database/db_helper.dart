import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../models/monitoring_form_model.dart';
import '../models/house_data_model.dart';
import '../utils/date_formatter.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dastak_monitoring.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT,
        name TEXT,
        designation TEXT,
        district TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE monitoring_sessions (
        id TEXT PRIMARY KEY,
        monitor_name TEXT,
        designation TEXT,
        posting_place TEXT,
        mobile_no TEXT,
        district TEXT,
        institution TEXT,
        monitoring_date TEXT,
        monitoring_time TEXT,
        is_high_risk_area INTEGER DEFAULT 0,
        block_name TEXT,
        area_type TEXT,
        village_ward_name TEXT,
        form_status TEXT DEFAULT 'draft',
        synced INTEGER DEFAULT 0,
        created_at TEXT,
        updated_at TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE house_monitoring_data (
        id TEXT PRIMARY KEY,
        session_id TEXT,
        house_number INTEGER,
        head_of_family TEXT,
        q1_1_aware_dastak TEXT,
        q1_2_source_codes TEXT,
        q1_3_received_message TEXT,
        q2_1_asha_visited TEXT,
        q2_2_asha_info_given TEXT,
        q2_3_asha_educated_prevention TEXT,
        q2_4_1_asha_educated_treatment TEXT,
        q2_4_2_asha_108_ambulance TEXT,
        q2_4_3_fever_on_visit_day TEXT,
        q2_4_4_asha_advised_hospital TEXT,
        q2_5_heatwave_message TEXT,
        q2_5_1_mosquito_breeding_info TEXT,
        q2_5_2_mosquito_source_check TEXT,
        q2_5_3_entomological_form TEXT,
        q2_6_1_fever_14days TEXT,
        q2_6_2_kala_azar_info TEXT,
        q2_7_1_tb_symptoms_educated TEXT,
        q2_7_2_tb_patient_identified TEXT,
        q2_7_3_tb_referred_health_center TEXT,
        q2_7_4_tb_treatment_ongoing TEXT,
        q2_7_5_tb_contacts_tested TEXT,
        q2_7_6_tb_positive_contacts_treated TEXT,
        q2_7_7_tb_negative_contacts_treated TEXT,
        q2_8_filaria_info TEXT,
        q2_8_1_leprosy_symptoms_info TEXT,
        q2_8_2_leprosy_patient_identified TEXT,
        q2_8_3_leprosy_referred TEXT,
        q2_9_scrub_typhus_info TEXT,
        q2_10_1_total_family_members INTEGER,
        q2_10_2_ili_cases_found INTEGER,
        q2_10_3_ili_not_listed INTEGER,
        q2_11_sticker_pasted TEXT,
        q2_12_handwash_demonstrated TEXT,
        q2_13_abha_id_created TEXT,
        q3_1_bush_cutting TEXT,
        q3_2_drain_cleaning TEXT,
        q3_3_waterlogging_removed TEXT,
        q3_4_other_cleaning TEXT,
        q3_5_fogging_done TEXT,
        q3_6_anti_larval_activity TEXT,
        q4_1_school_children_educated TEXT,
        q4_2_school_name_address TEXT,
        q4_3_heatwave_educated_school TEXT,
        q5_1_toilet_available TEXT,
        q5_2_toilet_used_by_all TEXT,
        q6_1_water_source TEXT,
        q6_2_water_purification_known TEXT,
        q7_1_anganwadi_visited TEXT,
        q7_2_anganwadi_nutrition_advice TEXT,
        q8_1_disease_prevention_meeting TEXT,
        q9_1_animal_husbandry TEXT,
        q9_2_veterinary_contact_info TEXT,
        q9_3_animals_away_from_residential TEXT,
        q10_1_farm_exists TEXT,
        q10_2_farm_sensitized TEXT,
        q11_1_chemicals_available TEXT,
        q11_2_cleanliness_proper TEXT,
        q11_3_fogging_larval_spray TEXT,
        q11_4_drinking_water_heatwave TEXT,
        q11_5_school_full_sleeve TEXT,
        q12_1_e_kavach_entry TEXT,
        q12_2_line_list_uploaded TEXT,
        q12_3_udsp_entry_known TEXT,
        asha_name TEXT,
        asha_mobile TEXT,
        q13_1_high_vector_list_available TEXT,
        q13_2_list_shared_departments TEXT,
        q14_1_idsp_vehicle_available TEXT,
        gram_vikas_adhikari_name TEXT,
        synced INTEGER DEFAULT 0,
        created_at TEXT,
        updated_at TEXT,
        FOREIGN KEY (session_id) REFERENCES monitoring_sessions(id)
      );
    ''');

    await db.execute('''
      INSERT OR IGNORE INTO users (username, password, name, designation, district)
      VALUES ('monitor', 'dastak@2026', 'Demo Monitor', 'Block Monitor', 'Lucknow');
    ''');
  }

  Future<UserModel?> getUser(String username, String password) async {
    final db = await instance.database;
    final maps = await db.query('users', where: 'username = ? AND password = ?', whereArgs: [username, password]);
    if (maps.isNotEmpty) return UserModel.fromMap(maps.first);
    return null;
  }

  Future<void> insertSession(MonitoringSession session) async {
    final db = await instance.database;
    await db.insert('monitoring_sessions', session.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateSession(MonitoringSession session) async {
    final db = await instance.database;
    await db.update('monitoring_sessions', session.toMap(), where: 'id = ?', whereArgs: [session.id]);
  }

  Future<void> deleteSession(String id) async {
    final db = await instance.database;
    await db.delete('house_monitoring_data', where: 'session_id = ?', whereArgs: [id]);
    await db.delete('monitoring_sessions', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<MonitoringSession>> getAllSessions() async {
    final db = await instance.database;
    final maps = await db.query('monitoring_sessions', orderBy: 'created_at DESC');
    return maps.map((json) => MonitoringSession.fromMap(json)).toList();
  }

  Future<void> insertHouse(HouseMonitoringData house) async {
    final db = await instance.database;
    await db.insert('house_monitoring_data', house.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<HouseMonitoringData>> getHousesForSession(String sessionId) async {
    final db = await instance.database;
    final maps = await db.query('house_monitoring_data', where: 'session_id = ?', whereArgs: [sessionId], orderBy: 'house_number');
    return maps.map((json) => HouseMonitoringData.fromMap(json)).toList();
  }

  Future<List<MonitoringSession>> getUnsyncedSessions() async {
    final db = await instance.database;
    final maps = await db.query('monitoring_sessions', where: 'synced = 0');
    return maps.map((json) => MonitoringSession.fromMap(json)).toList();
  }

  Future<List<HouseMonitoringData>> getUnsyncedHouses() async {
    final db = await instance.database;
    final maps = await db.query('house_monitoring_data', where: 'synced = 0');
    return maps.map((json) => HouseMonitoringData.fromMap(json)).toList();
  }

  Future<void> markSessionSynced(String id) async {
    final db = await instance.database;
    await db.update('monitoring_sessions', {'synced': 1}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> markHouseSynced(String id) async {
    final db = await instance.database;
    await db.update('house_monitoring_data', {'synced': 1}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> seedSampleData() async {
    final db = await instance.database;
    final sessionId = const Uuid().v4();
    final now = DateFormatter.currentDate();
    final nowTime = DateFormatter.currentTime();

    final session = MonitoringSession(
      id: sessionId,
      monitorName: 'Demo Monitor',
      designation: 'Block Monitor',
      postingPlace: 'Lucknow स्वास्थ्य विभाग',
      mobileNo: '9876543210',
      district: 'Lucknow',
      institution: 'स्वास्थ्य विभाग',
      monitoringDate: '2026-04-01',
      monitoringTime: '10:30',
      isHighRiskArea: 'हाँ',
      blockName: 'Sarojini Nagar',
      areaType: 'शहरी',
      villageWardName: 'Kachchi Basti',
      formStatus: 'complete',
      synced: 0,
      createdAt: now,
      updatedAt: now,
    );
    await insertSession(session);

    for (var i = 1; i <= 5; i++) {
      final house = HouseMonitoringData(
        id: const Uuid().v4(),
        sessionId: sessionId,
        houseNumber: i,
        headOfFamily: 'परिवार प्रमुख $i',
        q1_1_aware_dastak: 'हाँ',
        q1_2_source_codes: 'A - आशा/ए0एन0एम0',
        q1_3_received_message: 'हाँ',
        q2_1_asha_visited: 'हाँ',
        q2_2_asha_info_given: 'हाँ',
        q2_3_asha_educated_prevention: 'हाँ',
        q2_4_1_asha_educated_treatment: 'हाँ',
        q2_4_2_asha_108_ambulance: 'हाँ',
        q2_4_3_fever_on_visit_day: 'नहीं',
        q2_4_4_asha_advised_hospital: 'नहीं',
        q2_5_heatwave_message: 'हाँ',
        q2_5_1_mosquito_breeding_info: 'हाँ',
        q2_5_2_mosquito_source_check: 'हाँ',
        q2_5_3_entomological_form: 'हाँ',
        q2_6_1_fever_14days: 'नहीं',
        q2_6_2_kala_azar_info: 'नहीं',
        q2_7_1_tb_symptoms_educated: 'हाँ',
        q2_7_2_tb_patient_identified: 'नहीं',
        q2_7_3_tb_referred_health_center: 'नहीं',
        q2_7_4_tb_treatment_ongoing: 'नहीं',
        q2_7_5_tb_contacts_tested: 'नहीं',
        q2_7_6_tb_positive_contacts_treated: 'नहीं',
        q2_7_7_tb_negative_contacts_treated: 'नहीं',
        q2_8_filaria_info: 'नहीं',
        q2_8_1_leprosy_symptoms_info: 'हाँ',
        q2_8_2_leprosy_patient_identified: 'नहीं',
        q2_8_3_leprosy_referred: 'नहीं',
        q2_9_scrub_typhus_info: 'हाँ',
        q2_10_1_total_family_members: 5,
        q2_10_2_ili_cases_found: 0,
        q2_10_3_ili_not_listed: 0,
        q2_11_sticker_pasted: 'हाँ',
        q2_12_handwash_demonstrated: 'हाँ',
        q2_13_abha_id_created: 'हाँ',
        q3_1_bush_cutting: 'हाँ',
        q3_2_drain_cleaning: 'हाँ',
        q3_3_waterlogging_removed: 'हाँ',
        q3_4_other_cleaning: 'हाँ',
        q3_5_fogging_done: 'हाँ',
        q3_6_anti_larval_activity: 'हाँ',
        q4_1_school_children_educated: 'हाँ',
        q4_2_school_name_address: 'सरोजिनी नगर प्राथमिक विद्यालय',
        q4_3_heatwave_educated_school: 'हाँ',
        q5_1_toilet_available: 'हाँ',
        q5_2_toilet_used_by_all: 'हाँ',
        q6_1_water_source: 'B - सप्लाई वाला पानी',
        q6_2_water_purification_known: 'हाँ',
        q7_1_anganwadi_visited: 'हाँ',
        q7_2_anganwadi_nutrition_advice: 'हाँ',
        q8_1_disease_prevention_meeting: 'हाँ',
        q9_1_animal_husbandry: 'नहीं',
        q9_2_veterinary_contact_info: 'नहीं',
        q9_3_animals_away_from_residential: 'नहीं',
        q10_1_farm_exists: 'नहीं',
        q10_2_farm_sensitized: 'नहीं',
        q11_1_chemicals_available: 'हाँ',
        q11_2_cleanliness_proper: 'हाँ',
        q11_3_fogging_larval_spray: 'हाँ',
        q11_4_drinking_water_heatwave: 'हाँ',
        q11_5_school_full_sleeve: 'सभी छात्र पूरी आस्तीन की यूनिफॉर्म पहने पाए गए',
        q12_1_e_kavach_entry: 'हाँ',
        q12_2_line_list_uploaded: 'हाँ',
        q12_3_udsp_entry_known: 'हाँ',
        ashaName: 'आशा देवी',
        ashaMobile: '9876501234',
        q13_1_high_vector_list_available: 'हाँ',
        q13_2_list_shared_departments: 'हाँ',
        q14_1_idsp_vehicle_available: 'हाँ',
        gramVikasAdhikariName: 'ग्राम विकास अधिकारी शर्मा',
        synced: 0,
        createdAt: now,
        updatedAt: now,
      );
      await insertHouse(house);
    }
  }
}
