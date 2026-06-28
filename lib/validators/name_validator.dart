class NameValidator {
  NameValidator._();

  static const String _emptyError = 'Name cannot be empty.';
  static const String _tooShortError = 'Name must be at least 2 characters.';
  static const String _invalidError = 'Name can only contain letters and spaces.';

  static final RegExp _nameRegex = RegExp(r'^[a-zA-Z\s]+$');

  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _emptyError;
    }
    if (value.trim().length < 2) {
      return _tooShortError;
    }
    if (!_nameRegex.hasMatch(value.trim())) {
      return _invalidError;
    }
    return null;
  }
}