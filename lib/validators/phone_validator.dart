class PhoneValidator {
  PhoneValidator._();

  static const String _emptyError = 'Phone number cannot be empty.';
  static const String _invalidError = 'Please enter a valid 10-digit phone number.';

  static final RegExp _phoneRegex = RegExp(r'^[0-9]{10}$');

  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return _emptyError;
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return _invalidError;
    }
    return null;
  }
}