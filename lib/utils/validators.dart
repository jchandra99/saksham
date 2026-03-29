class Validators {
  static String? nonEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName भरा जाना आवश्यक है';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'मोबाइल नंबर आवश्यक है';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      return 'कृपया 10 अंकों का सही मोबाइल नंबर डालें';
    }
    return null;
  }
}
