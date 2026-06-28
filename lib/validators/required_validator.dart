class RequiredValidator {
  RequiredValidator._();

  static const String _defaultError = 'This field cannot be empty.';

  static String? validate(
    String? value, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty.';
    }
    return null;
  }

  static String? validateWithDefault(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _defaultError;
    }
    return null;
  }
}