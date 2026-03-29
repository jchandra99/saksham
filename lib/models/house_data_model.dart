class HouseMonitoringData {
  final String id;
  String sessionId;
  int houseNumber;
  String headOfFamily;
  String q1_1_aware_dastak;
  String q1_2_source_codes;
  String q1_3_received_message;
  String q2_1_asha_visited;
  String q2_2_asha_info_given;
  String q2_3_asha_educated_prevention;
  String q2_4_1_asha_educated_treatment;
  String q2_4_2_asha_108_ambulance;
  String q2_4_3_fever_on_visit_day;
  String q2_4_4_asha_advised_hospital;
  String q2_5_heatwave_message;
  String q2_5_1_mosquito_breeding_info;
  String q2_5_2_mosquito_source_check;
  String q2_5_3_entomological_form;
  String q2_6_1_fever_14days;
  String q2_6_2_kala_azar_info;
  String q2_7_1_tb_symptoms_educated;
  String q2_7_2_tb_patient_identified;
  String q2_7_3_tb_referred_health_center;
  String q2_7_4_tb_treatment_ongoing;
  String q2_7_5_tb_contacts_tested;
  String q2_7_6_tb_positive_contacts_treated;
  String q2_7_7_tb_negative_contacts_treated;
  String q2_8_filaria_info;
  String q2_8_1_leprosy_symptoms_info;
  String q2_8_2_leprosy_patient_identified;
  String q2_8_3_leprosy_referred;
  String q2_9_scrub_typhus_info;
  int q2_10_1_total_family_members;
  int q2_10_2_ili_cases_found;
  int q2_10_3_ili_not_listed;
  String q2_11_sticker_pasted;
  String q2_12_handwash_demonstrated;
  String q2_13_abha_id_created;
  String q3_1_bush_cutting;
  String q3_2_drain_cleaning;
  String q3_3_waterlogging_removed;
  String q3_4_other_cleaning;
  String q3_5_fogging_done;
  String q3_6_anti_larval_activity;
  String q4_1_school_children_educated;
  String q4_2_school_name_address;
  String q4_3_heatwave_educated_school;
  String q5_1_toilet_available;
  String q5_2_toilet_used_by_all;
  String q6_1_water_source;
  String q6_2_water_purification_known;
  String q7_1_anganwadi_visited;
  String q7_2_anganwadi_nutrition_advice;
  String q8_1_disease_prevention_meeting;
  String q9_1_animal_husbandry;
  String q9_2_veterinary_contact_info;
  String q9_3_animals_away_from_residential;
  String q10_1_farm_exists;
  String q10_2_farm_sensitized;
  String q11_1_chemicals_available;
  String q11_2_cleanliness_proper;
  String q11_3_fogging_larval_spray;
  String q11_4_drinking_water_heatwave;
  String q11_5_school_full_sleeve;
  String q12_1_e_kavach_entry;
  String q12_2_line_list_uploaded;
  String q12_3_udsp_entry_known;
  String ashaName;
  String ashaMobile;
  String q13_1_high_vector_list_available;
  String q13_2_list_shared_departments;
  String q14_1_idsp_vehicle_available;
  String gramVikasAdhikariName;
  int synced;
  String createdAt;
  String updatedAt;

  HouseMonitoringData({
    required this.id,
    required this.sessionId,
    required this.houseNumber,
    this.headOfFamily = '',
    this.q1_1_aware_dastak = 'नहीं',
    this.q1_2_source_codes = '',
    this.q1_3_received_message = 'नहीं',
    this.q2_1_asha_visited = 'नहीं',
    this.q2_2_asha_info_given = 'नहीं',
    this.q2_3_asha_educated_prevention = 'नहीं',
    this.q2_4_1_asha_educated_treatment = 'नहीं',
    this.q2_4_2_asha_108_ambulance = 'नहीं',
    this.q2_4_3_fever_on_visit_day = 'नहीं',
    this.q2_4_4_asha_advised_hospital = 'नहीं',
    this.q2_5_heatwave_message = 'नहीं',
    this.q2_5_1_mosquito_breeding_info = 'नहीं',
    this.q2_5_2_mosquito_source_check = 'नहीं',
    this.q2_5_3_entomological_form = 'नहीं',
    this.q2_6_1_fever_14days = 'नहीं',
    this.q2_6_2_kala_azar_info = 'नहीं',
    this.q2_7_1_tb_symptoms_educated = 'नहीं',
    this.q2_7_2_tb_patient_identified = 'नहीं',
    this.q2_7_3_tb_referred_health_center = 'नहीं',
    this.q2_7_4_tb_treatment_ongoing = 'नहीं',
    this.q2_7_5_tb_contacts_tested = 'नहीं',
    this.q2_7_6_tb_positive_contacts_treated = 'नहीं',
    this.q2_7_7_tb_negative_contacts_treated = 'नहीं',
    this.q2_8_filaria_info = 'नहीं',
    this.q2_8_1_leprosy_symptoms_info = 'नहीं',
    this.q2_8_2_leprosy_patient_identified = 'नहीं',
    this.q2_8_3_leprosy_referred = 'नहीं',
    this.q2_9_scrub_typhus_info = 'नहीं',
    this.q2_10_1_total_family_members = 0,
    this.q2_10_2_ili_cases_found = 0,
    this.q2_10_3_ili_not_listed = 0,
    this.q2_11_sticker_pasted = 'नहीं',
    this.q2_12_handwash_demonstrated = 'नहीं',
    this.q2_13_abha_id_created = 'नहीं',
    this.q3_1_bush_cutting = 'नहीं',
    this.q3_2_drain_cleaning = 'नहीं',
    this.q3_3_waterlogging_removed = 'नहीं',
    this.q3_4_other_cleaning = 'नहीं',
    this.q3_5_fogging_done = 'नहीं',
    this.q3_6_anti_larval_activity = 'नहीं',
    this.q4_1_school_children_educated = 'नहीं',
    this.q4_2_school_name_address = '',
    this.q4_3_heatwave_educated_school = 'नहीं',
    this.q5_1_toilet_available = 'नहीं',
    this.q5_2_toilet_used_by_all = 'नहीं',
    this.q6_1_water_source = '',
    this.q6_2_water_purification_known = 'नहीं',
    this.q7_1_anganwadi_visited = 'नहीं',
    this.q7_2_anganwadi_nutrition_advice = 'नहीं',
    this.q8_1_disease_prevention_meeting = 'नहीं',
    this.q9_1_animal_husbandry = 'नहीं',
    this.q9_2_veterinary_contact_info = 'नहीं',
    this.q9_3_animals_away_from_residential = 'नहीं',
    this.q10_1_farm_exists = 'नहीं',
    this.q10_2_farm_sensitized = 'नहीं',
    this.q11_1_chemicals_available = 'नहीं',
    this.q11_2_cleanliness_proper = 'नहीं',
    this.q11_3_fogging_larval_spray = 'नहीं',
    this.q11_4_drinking_water_heatwave = 'नहीं',
    this.q11_5_school_full_sleeve = 'सभी छात्र पूरी आस्तीन की यूनिफॉर्म पहने पाए गए',
    this.q12_1_e_kavach_entry = 'आशा नहीं मिली',
    this.q12_2_line_list_uploaded = 'हाँ',
    this.q12_3_udsp_entry_known = 'नहीं',
    this.ashaName = '',
    this.ashaMobile = '',
    this.q13_1_high_vector_list_available = 'नहीं',
    this.q13_2_list_shared_departments = 'नहीं',
    this.q14_1_idsp_vehicle_available = 'नहीं',
    this.gramVikasAdhikariName = '',
    this.synced = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HouseMonitoringData.fromMap(Map<String, dynamic> map) {
    return HouseMonitoringData(
      id: map['id'] ?? '',
      sessionId: map['session_id'] ?? '',
      houseNumber: map['house_number'] ?? 1,
      headOfFamily: map['head_of_family'] ?? '',
      q1_1_aware_dastak: map['q1_1_aware_dastak'] ?? 'नहीं',
      q1_2_source_codes: map['q1_2_source_codes'] ?? '',
      q1_3_received_message: map['q1_3_received_message'] ?? 'नहीं',
      q2_1_asha_visited: map['q2_1_asha_visited'] ?? 'नहीं',
      q2_2_asha_info_given: map['q2_2_asha_info_given'] ?? 'नहीं',
      q2_3_asha_educated_prevention: map['q2_3_asha_educated_prevention'] ?? 'नहीं',
      q2_4_1_asha_educated_treatment: map['q2_4_1_asha_educated_treatment'] ?? 'नहीं',
      q2_4_2_asha_108_ambulance: map['q2_4_2_asha_108_ambulance'] ?? 'नहीं',
      q2_4_3_fever_on_visit_day: map['q2_4_3_fever_on_visit_day'] ?? 'नहीं',
      q2_4_4_asha_advised_hospital: map['q2_4_4_asha_advised_hospital'] ?? 'नहीं',
      q2_5_heatwave_message: map['q2_5_heatwave_message'] ?? 'नहीं',
      q2_5_1_mosquito_breeding_info: map['q2_5_1_mosquito_breeding_info'] ?? 'नहीं',
      q2_5_2_mosquito_source_check: map['q2_5_2_mosquito_source_check'] ?? 'नहीं',
      q2_5_3_entomological_form: map['q2_5_3_entomological_form'] ?? 'नहीं',
      q2_6_1_fever_14days: map['q2_6_1_fever_14days'] ?? 'नहीं',
      q2_6_2_kala_azar_info: map['q2_6_2_kala_azar_info'] ?? 'नहीं',
      q2_7_1_tb_symptoms_educated: map['q2_7_1_tb_symptoms_educated'] ?? 'नहीं',
      q2_7_2_tb_patient_identified: map['q2_7_2_tb_patient_identified'] ?? 'नहीं',
      q2_7_3_tb_referred_health_center: map['q2_7_3_tb_referred_health_center'] ?? 'नहीं',
      q2_7_4_tb_treatment_ongoing: map['q2_7_4_tb_treatment_ongoing'] ?? 'नहीं',
      q2_7_5_tb_contacts_tested: map['q2_7_5_tb_contacts_tested'] ?? 'नहीं',
      q2_7_6_tb_positive_contacts_treated: map['q2_7_6_tb_positive_contacts_treated'] ?? 'नहीं',
      q2_7_7_tb_negative_contacts_treated: map['q2_7_7_tb_negative_contacts_treated'] ?? 'नहीं',
      q2_8_filaria_info: map['q2_8_filaria_info'] ?? 'नहीं',
      q2_8_1_leprosy_symptoms_info: map['q2_8_1_leprosy_symptoms_info'] ?? 'नहीं',
      q2_8_2_leprosy_patient_identified: map['q2_8_2_leprosy_patient_identified'] ?? 'नहीं',
      q2_8_3_leprosy_referred: map['q2_8_3_leprosy_referred'] ?? 'नहीं',
      q2_9_scrub_typhus_info: map['q2_9_scrub_typhus_info'] ?? 'नहीं',
      q2_10_1_total_family_members: map['q2_10_1_total_family_members'] ?? 0,
      q2_10_2_ili_cases_found: map['q2_10_2_ili_cases_found'] ?? 0,
      q2_10_3_ili_not_listed: map['q2_10_3_ili_not_listed'] ?? 0,
      q2_11_sticker_pasted: map['q2_11_sticker_pasted'] ?? 'नहीं',
      q2_12_handwash_demonstrated: map['q2_12_handwash_demonstrated'] ?? 'नहीं',
      q2_13_abha_id_created: map['q2_13_abha_id_created'] ?? 'नहीं',
      q3_1_bush_cutting: map['q3_1_bush_cutting'] ?? 'नहीं',
      q3_2_drain_cleaning: map['q3_2_drain_cleaning'] ?? 'नहीं',
      q3_3_waterlogging_removed: map['q3_3_waterlogging_removed'] ?? 'नहीं',
      q3_4_other_cleaning: map['q3_4_other_cleaning'] ?? 'नहीं',
      q3_5_fogging_done: map['q3_5_fogging_done'] ?? 'नहीं',
      q3_6_anti_larval_activity: map['q3_6_anti_larval_activity'] ?? 'नहीं',
      q4_1_school_children_educated: map['q4_1_school_children_educated'] ?? 'नहीं',
      q4_2_school_name_address: map['q4_2_school_name_address'] ?? '',
      q4_3_heatwave_educated_school: map['q4_3_heatwave_educated_school'] ?? 'नहीं',
      q5_1_toilet_available: map['q5_1_toilet_available'] ?? 'नहीं',
      q5_2_toilet_used_by_all: map['q5_2_toilet_used_by_all'] ?? 'नहीं',
      q6_1_water_source: map['q6_1_water_source'] ?? '',
      q6_2_water_purification_known: map['q6_2_water_purification_known'] ?? 'नहीं',
      q7_1_anganwadi_visited: map['q7_1_anganwadi_visited'] ?? 'नहीं',
      q7_2_anganwadi_nutrition_advice: map['q7_2_anganwadi_nutrition_advice'] ?? 'नहीं',
      q8_1_disease_prevention_meeting: map['q8_1_disease_prevention_meeting'] ?? 'नहीं',
      q9_1_animal_husbandry: map['q9_1_animal_husbandry'] ?? 'नहीं',
      q9_2_veterinary_contact_info: map['q9_2_veterinary_contact_info'] ?? 'नहीं',
      q9_3_animals_away_from_residential: map['q9_3_animals_away_from_residential'] ?? 'नहीं',
      q10_1_farm_exists: map['q10_1_farm_exists'] ?? 'नहीं',
      q10_2_farm_sensitized: map['q10_2_farm_sensitized'] ?? 'नहीं',
      q11_1_chemicals_available: map['q11_1_chemicals_available'] ?? 'नहीं',
      q11_2_cleanliness_proper: map['q11_2_cleanliness_proper'] ?? 'नहीं',
      q11_3_fogging_larval_spray: map['q11_3_fogging_larval_spray'] ?? 'नहीं',
      q11_4_drinking_water_heatwave: map['q11_4_drinking_water_heatwave'] ?? 'नहीं',
      q11_5_school_full_sleeve: map['q11_5_school_full_sleeve'] ?? 'सभी छात्र पूरी आस्तीन की यूनिफॉर्म पहने पाए गए',
      q12_1_e_kavach_entry: map['q12_1_e_kavach_entry'] ?? 'आशा नहीं मिली',
      q12_2_line_list_uploaded: map['q12_2_line_list_uploaded'] ?? 'हाँ',
      q12_3_udsp_entry_known: map['q12_3_udsp_entry_known'] ?? 'नहीं',
      ashaName: map['asha_name'] ?? '',
      ashaMobile: map['asha_mobile'] ?? '',
      q13_1_high_vector_list_available: map['q13_1_high_vector_list_available'] ?? 'नहीं',
      q13_2_list_shared_departments: map['q13_2_list_shared_departments'] ?? 'नहीं',
      q14_1_idsp_vehicle_available: map['q14_1_idsp_vehicle_available'] ?? 'नहीं',
      gramVikasAdhikariName: map['gram_vikas_adhikari_name'] ?? '',
      synced: map['synced'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'session_id': sessionId,
      'house_number': houseNumber,
      'head_of_family': headOfFamily,
      'q1_1_aware_dastak': q1_1_aware_dastak,
      'q1_2_source_codes': q1_2_source_codes,
      'q1_3_received_message': q1_3_received_message,
      'q2_1_asha_visited': q2_1_asha_visited,
      'q2_2_asha_info_given': q2_2_asha_info_given,
      'q2_3_asha_educated_prevention': q2_3_asha_educated_prevention,
      'q2_4_1_asha_educated_treatment': q2_4_1_asha_educated_treatment,
      'q2_4_2_asha_108_ambulance': q2_4_2_asha_108_ambulance,
      'q2_4_3_fever_on_visit_day': q2_4_3_fever_on_visit_day,
      'q2_4_4_asha_advised_hospital': q2_4_4_asha_advised_hospital,
      'q2_5_heatwave_message': q2_5_heatwave_message,
      'q2_5_1_mosquito_breeding_info': q2_5_1_mosquito_breeding_info,
      'q2_5_2_mosquito_source_check': q2_5_2_mosquito_source_check,
      'q2_5_3_entomological_form': q2_5_3_entomological_form,
      'q2_6_1_fever_14days': q2_6_1_fever_14days,
      'q2_6_2_kala_azar_info': q2_6_2_kala_azar_info,
      'q2_7_1_tb_symptoms_educated': q2_7_1_tb_symptoms_educated,
      'q2_7_2_tb_patient_identified': q2_7_2_tb_patient_identified,
      'q2_7_3_tb_referred_health_center': q2_7_3_tb_referred_health_center,
      'q2_7_4_tb_treatment_ongoing': q2_7_4_tb_treatment_ongoing,
      'q2_7_5_tb_contacts_tested': q2_7_5_tb_contacts_tested,
      'q2_7_6_tb_positive_contacts_treated': q2_7_6_tb_positive_contacts_treated,
      'q2_7_7_tb_negative_contacts_treated': q2_7_7_tb_negative_contacts_treated,
      'q2_8_filaria_info': q2_8_filaria_info,
      'q2_8_1_leprosy_symptoms_info': q2_8_1_leprosy_symptoms_info,
      'q2_8_2_leprosy_patient_identified': q2_8_2_leprosy_patient_identified,
      'q2_8_3_leprosy_referred': q2_8_3_leprosy_referred,
      'q2_9_scrub_typhus_info': q2_9_scrub_typhus_info,
      'q2_10_1_total_family_members': q2_10_1_total_family_members,
      'q2_10_2_ili_cases_found': q2_10_2_ili_cases_found,
      'q2_10_3_ili_not_listed': q2_10_3_ili_not_listed,
      'q2_11_sticker_pasted': q2_11_sticker_pasted,
      'q2_12_handwash_demonstrated': q2_12_handwash_demonstrated,
      'q2_13_abha_id_created': q2_13_abha_id_created,
      'q3_1_bush_cutting': q3_1_bush_cutting,
      'q3_2_drain_cleaning': q3_2_drain_cleaning,
      'q3_3_waterlogging_removed': q3_3_waterlogging_removed,
      'q3_4_other_cleaning': q3_4_other_cleaning,
      'q3_5_fogging_done': q3_5_fogging_done,
      'q3_6_anti_larval_activity': q3_6_anti_larval_activity,
      'q4_1_school_children_educated': q4_1_school_children_educated,
      'q4_2_school_name_address': q4_2_school_name_address,
      'q4_3_heatwave_educated_school': q4_3_heatwave_educated_school,
      'q5_1_toilet_available': q5_1_toilet_available,
      'q5_2_toilet_used_by_all': q5_2_toilet_used_by_all,
      'q6_1_water_source': q6_1_water_source,
      'q6_2_water_purification_known': q6_2_water_purification_known,
      'q7_1_anganwadi_visited': q7_1_anganwadi_visited,
      'q7_2_anganwadi_nutrition_advice': q7_2_anganwadi_nutrition_advice,
      'q8_1_disease_prevention_meeting': q8_1_disease_prevention_meeting,
      'q9_1_animal_husbandry': q9_1_animal_husbandry,
      'q9_2_veterinary_contact_info': q9_2_veterinary_contact_info,
      'q9_3_animals_away_from_residential': q9_3_animals_away_from_residential,
      'q10_1_farm_exists': q10_1_farm_exists,
      'q10_2_farm_sensitized': q10_2_farm_sensitized,
      'q11_1_chemicals_available': q11_1_chemicals_available,
      'q11_2_cleanliness_proper': q11_2_cleanliness_proper,
      'q11_3_fogging_larval_spray': q11_3_fogging_larval_spray,
      'q11_4_drinking_water_heatwave': q11_4_drinking_water_heatwave,
      'q11_5_school_full_sleeve': q11_5_school_full_sleeve,
      'q12_1_e_kavach_entry': q12_1_e_kavach_entry,
      'q12_2_line_list_uploaded': q12_2_line_list_uploaded,
      'q12_3_udsp_entry_known': q12_3_udsp_entry_known,
      'asha_name': ashaName,
      'asha_mobile': ashaMobile,
      'q13_1_high_vector_list_available': q13_1_high_vector_list_available,
      'q13_2_list_shared_departments': q13_2_list_shared_departments,
      'q14_1_idsp_vehicle_available': q14_1_idsp_vehicle_available,
      'gram_vikas_adhikari_name': gramVikasAdhikariName,
      'synced': synced,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  HouseMonitoringData copyWith({
    String? id,
    String? sessionId,
    int? houseNumber,
    String? headOfFamily,
    String? q1_1_aware_dastak,
    String? q1_2_source_codes,
    String? q1_3_received_message,
    String? q2_1_asha_visited,
    String? q2_2_asha_info_given,
    String? q2_3_asha_educated_prevention,
    String? q2_4_1_asha_educated_treatment,
    String? q2_4_2_asha_108_ambulance,
    String? q2_4_3_fever_on_visit_day,
    String? q2_4_4_asha_advised_hospital,
    String? q2_5_heatwave_message,
    String? q2_5_1_mosquito_breeding_info,
    String? q2_5_2_mosquito_source_check,
    String? q2_5_3_entomological_form,
    String? q2_6_1_fever_14days,
    String? q2_6_2_kala_azar_info,
    String? q2_7_1_tb_symptoms_educated,
    String? q2_7_2_tb_patient_identified,
    String? q2_7_3_tb_referred_health_center,
    String? q2_7_4_tb_treatment_ongoing,
    String? q2_7_5_tb_contacts_tested,
    String? q2_7_6_tb_positive_contacts_treated,
    String? q2_7_7_tb_negative_contacts_treated,
    String? q2_8_filaria_info,
    String? q2_8_1_leprosy_symptoms_info,
    String? q2_8_2_leprosy_patient_identified,
    String? q2_8_3_leprosy_referred,
    String? q2_9_scrub_typhus_info,
    int? q2_10_1_total_family_members,
    int? q2_10_2_ili_cases_found,
    int? q2_10_3_ili_not_listed,
    String? q2_11_sticker_pasted,
    String? q2_12_handwash_demonstrated,
    String? q2_13_abha_id_created,
    String? q3_1_bush_cutting,
    String? q3_2_drain_cleaning,
    String? q3_3_waterlogging_removed,
    String? q3_4_other_cleaning,
    String? q3_5_fogging_done,
    String? q3_6_anti_larval_activity,
    String? q4_1_school_children_educated,
    String? q4_2_school_name_address,
    String? q4_3_heatwave_educated_school,
    String? q5_1_toilet_available,
    String? q5_2_toilet_used_by_all,
    String? q6_1_water_source,
    String? q6_2_water_purification_known,
    String? q7_1_anganwadi_visited,
    String? q7_2_anganwadi_nutrition_advice,
    String? q8_1_disease_prevention_meeting,
    String? q9_1_animal_husbandry,
    String? q9_2_veterinary_contact_info,
    String? q9_3_animals_away_from_residential,
    String? q10_1_farm_exists,
    String? q10_2_farm_sensitized,
    String? q11_1_chemicals_available,
    String? q11_2_cleanliness_proper,
    String? q11_3_fogging_larval_spray,
    String? q11_4_drinking_water_heatwave,
    String? q11_5_school_full_sleeve,
    String? q12_1_e_kavach_entry,
    String? q12_2_line_list_uploaded,
    String? q12_3_udsp_entry_known,
    String? ashaName,
    String? ashaMobile,
    String? q13_1_high_vector_list_available,
    String? q13_2_list_shared_departments,
    String? q14_1_idsp_vehicle_available,
    String? gramVikasAdhikariName,
    int? synced,
    String? createdAt,
    String? updatedAt,
  }) {
    return HouseMonitoringData(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      houseNumber: houseNumber ?? this.houseNumber,
      headOfFamily: headOfFamily ?? this.headOfFamily,
      q1_1_aware_dastak: q1_1_aware_dastak ?? this.q1_1_aware_dastak,
      q1_2_source_codes: q1_2_source_codes ?? this.q1_2_source_codes,
      q1_3_received_message: q1_3_received_message ?? this.q1_3_received_message,
      q2_1_asha_visited: q2_1_asha_visited ?? this.q2_1_asha_visited,
      q2_2_asha_info_given: q2_2_asha_info_given ?? this.q2_2_asha_info_given,
      q2_3_asha_educated_prevention: q2_3_asha_educated_prevention ?? this.q2_3_asha_educated_prevention,
      q2_4_1_asha_educated_treatment: q2_4_1_asha_educated_treatment ?? this.q2_4_1_asha_educated_treatment,
      q2_4_2_asha_108_ambulance: q2_4_2_asha_108_ambulance ?? this.q2_4_2_asha_108_ambulance,
      q2_4_3_fever_on_visit_day: q2_4_3_fever_on_visit_day ?? this.q2_4_3_fever_on_visit_day,
      q2_4_4_asha_advised_hospital: q2_4_4_asha_advised_hospital ?? this.q2_4_4_asha_advised_hospital,
      q2_5_heatwave_message: q2_5_heatwave_message ?? this.q2_5_heatwave_message,
      q2_5_1_mosquito_breeding_info: q2_5_1_mosquito_breeding_info ?? this.q2_5_1_mosquito_breeding_info,
      q2_5_2_mosquito_source_check: q2_5_2_mosquito_source_check ?? this.q2_5_2_mosquito_source_check,
      q2_5_3_entomological_form: q2_5_3_entomological_form ?? this.q2_5_3_entomological_form,
      q2_6_1_fever_14days: q2_6_1_fever_14days ?? this.q2_6_1_fever_14days,
      q2_6_2_kala_azar_info: q2_6_2_kala_azar_info ?? this.q2_6_2_kala_azar_info,
      q2_7_1_tb_symptoms_educated: q2_7_1_tb_symptoms_educated ?? this.q2_7_1_tb_symptoms_educated,
      q2_7_2_tb_patient_identified: q2_7_2_tb_patient_identified ?? this.q2_7_2_tb_patient_identified,
      q2_7_3_tb_referred_health_center: q2_7_3_tb_referred_health_center ?? this.q2_7_3_tb_referred_health_center,
      q2_7_4_tb_treatment_ongoing: q2_7_4_tb_treatment_ongoing ?? this.q2_7_4_tb_treatment_ongoing,
      q2_7_5_tb_contacts_tested: q2_7_5_tb_contacts_tested ?? this.q2_7_5_tb_contacts_tested,
      q2_7_6_tb_positive_contacts_treated: q2_7_6_tb_positive_contacts_treated ?? this.q2_7_6_tb_positive_contacts_treated,
      q2_7_7_tb_negative_contacts_treated: q2_7_7_tb_negative_contacts_treated ?? this.q2_7_7_tb_negative_contacts_treated,
      q2_8_filaria_info: q2_8_filaria_info ?? this.q2_8_filaria_info,
      q2_8_1_leprosy_symptoms_info: q2_8_1_leprosy_symptoms_info ?? this.q2_8_1_leprosy_symptoms_info,
      q2_8_2_leprosy_patient_identified: q2_8_2_leprosy_patient_identified ?? this.q2_8_2_leprosy_patient_identified,
      q2_8_3_leprosy_referred: q2_8_3_leprosy_referred ?? this.q2_8_3_leprosy_referred,
      q2_9_scrub_typhus_info: q2_9_scrub_typhus_info ?? this.q2_9_scrub_typhus_info,
      q2_10_1_total_family_members: q2_10_1_total_family_members ?? this.q2_10_1_total_family_members,
      q2_10_2_ili_cases_found: q2_10_2_ili_cases_found ?? this.q2_10_2_ili_cases_found,
      q2_10_3_ili_not_listed: q2_10_3_ili_not_listed ?? this.q2_10_3_ili_not_listed,
      q2_11_sticker_pasted: q2_11_sticker_pasted ?? this.q2_11_sticker_pasted,
      q2_12_handwash_demonstrated: q2_12_handwash_demonstrated ?? this.q2_12_handwash_demonstrated,
      q2_13_abha_id_created: q2_13_abha_id_created ?? this.q2_13_abha_id_created,
      q3_1_bush_cutting: q3_1_bush_cutting ?? this.q3_1_bush_cutting,
      q3_2_drain_cleaning: q3_2_drain_cleaning ?? this.q3_2_drain_cleaning,
      q3_3_waterlogging_removed: q3_3_waterlogging_removed ?? this.q3_3_waterlogging_removed,
      q3_4_other_cleaning: q3_4_other_cleaning ?? this.q3_4_other_cleaning,
      q3_5_fogging_done: q3_5_fogging_done ?? this.q3_5_fogging_done,
      q3_6_anti_larval_activity: q3_6_anti_larval_activity ?? this.q3_6_anti_larval_activity,
      q4_1_school_children_educated: q4_1_school_children_educated ?? this.q4_1_school_children_educated,
      q4_2_school_name_address: q4_2_school_name_address ?? this.q4_2_school_name_address,
      q4_3_heatwave_educated_school: q4_3_heatwave_educated_school ?? this.q4_3_heatwave_educated_school,
      q5_1_toilet_available: q5_1_toilet_available ?? this.q5_1_toilet_available,
      q5_2_toilet_used_by_all: q5_2_toilet_used_by_all ?? this.q5_2_toilet_used_by_all,
      q6_1_water_source: q6_1_water_source ?? this.q6_1_water_source,
      q6_2_water_purification_known: q6_2_water_purification_known ?? this.q6_2_water_purification_known,
      q7_1_anganwadi_visited: q7_1_anganwadi_visited ?? this.q7_1_anganwadi_visited,
      q7_2_anganwadi_nutrition_advice: q7_2_anganwadi_nutrition_advice ?? this.q7_2_anganwadi_nutrition_advice,
      q8_1_disease_prevention_meeting: q8_1_disease_prevention_meeting ?? this.q8_1_disease_prevention_meeting,
      q9_1_animal_husbandry: q9_1_animal_husbandry ?? this.q9_1_animal_husbandry,
      q9_2_veterinary_contact_info: q9_2_veterinary_contact_info ?? this.q9_2_veterinary_contact_info,
      q9_3_animals_away_from_residential: q9_3_animals_away_from_residential ?? this.q9_3_animals_away_from_residential,
      q10_1_farm_exists: q10_1_farm_exists ?? this.q10_1_farm_exists,
      q10_2_farm_sensitized: q10_2_farm_sensitized ?? this.q10_2_farm_sensitized,
      q11_1_chemicals_available: q11_1_chemicals_available ?? this.q11_1_chemicals_available,
      q11_2_cleanliness_proper: q11_2_cleanliness_proper ?? this.q11_2_cleanliness_proper,
      q11_3_fogging_larval_spray: q11_3_fogging_larval_spray ?? this.q11_3_fogging_larval_spray,
      q11_4_drinking_water_heatwave: q11_4_drinking_water_heatwave ?? this.q11_4_drinking_water_heatwave,
      q11_5_school_full_sleeve: q11_5_school_full_sleeve ?? this.q11_5_school_full_sleeve,
      q12_1_e_kavach_entry: q12_1_e_kavach_entry ?? this.q12_1_e_kavach_entry,
      q12_2_line_list_uploaded: q12_2_line_list_uploaded ?? this.q12_2_line_list_uploaded,
      q12_3_udsp_entry_known: q12_3_udsp_entry_known ?? this.q12_3_udsp_entry_known,
      ashaName: ashaName ?? this.ashaName,
      ashaMobile: ashaMobile ?? this.ashaMobile,
      q13_1_high_vector_list_available: q13_1_high_vector_list_available ?? this.q13_1_high_vector_list_available,
      q13_2_list_shared_departments: q13_2_list_shared_departments ?? this.q13_2_list_shared_departments,
      q14_1_idsp_vehicle_available: q14_1_idsp_vehicle_available ?? this.q14_1_idsp_vehicle_available,
      gramVikasAdhikariName: gramVikasAdhikariName ?? this.gramVikasAdhikariName,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
