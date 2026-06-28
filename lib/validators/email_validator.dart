class EmailValidator {
  EmailValidator._();

  static const String _emptyError = 'Email cannot be empty.';
  static const String _invalidError = 'Please enter a valid email address.';

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _emptyError;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return _invalidError;
    }
    return null;
  }
}