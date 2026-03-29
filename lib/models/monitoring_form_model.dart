class MonitoringSession {
  final String id;
  String monitorName;
  String designation;
  String postingPlace;
  String mobileNo;
  String district;
  String institution;
  String monitoringDate;
  String monitoringTime;
  String isHighRiskArea;
  String blockName;
  String areaType;
  String villageWardName;
  String formStatus;
  int synced;
  String createdAt;
  String updatedAt;

  MonitoringSession({
    required this.id,
    this.monitorName = '',
    this.designation = '',
    this.postingPlace = '',
    this.mobileNo = '',
    this.district = '',
    this.institution = 'स्वास्थ्य विभाग',
    this.monitoringDate = '',
    this.monitoringTime = '',
    this.isHighRiskArea = 'नहीं',
    this.blockName = '',
    this.areaType = 'शहरी',
    this.villageWardName = '',
    this.formStatus = 'draft',
    this.synced = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MonitoringSession.fromMap(Map<String, dynamic> map) {
    return MonitoringSession(
      id: map['id'] ?? '',
      monitorName: map['monitor_name'] ?? '',
      designation: map['designation'] ?? '',
      postingPlace: map['posting_place'] ?? '',
      mobileNo: map['mobile_no'] ?? '',
      district: map['district'] ?? '',
      institution: map['institution'] ?? 'स्वास्थ्य विभाग',
      monitoringDate: map['monitoring_date'] ?? '',
      monitoringTime: map['monitoring_time'] ?? '',
      isHighRiskArea: map['is_high_risk_area'] == 1 ? 'हाँ' : 'नहीं',
      blockName: map['block_name'] ?? '',
      areaType: map['area_type'] ?? 'शहरी',
      villageWardName: map['village_ward_name'] ?? '',
      formStatus: map['form_status'] ?? 'draft',
      synced: map['synced'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monitor_name': monitorName,
      'designation': designation,
      'posting_place': postingPlace,
      'mobile_no': mobileNo,
      'district': district,
      'institution': institution,
      'monitoring_date': monitoringDate,
      'monitoring_time': monitoringTime,
      'is_high_risk_area': isHighRiskArea == 'हाँ' ? 1 : 0,
      'block_name': blockName,
      'area_type': areaType,
      'village_ward_name': villageWardName,
      'form_status': formStatus,
      'synced': synced,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
