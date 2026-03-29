class UserModel {
  final int? id;
  final String username;
  final String password;
  final String name;
  final String designation;
  final String district;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.designation,
    required this.district,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      district: map['district'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'designation': designation,
      'district': district,
    };
  }
}
