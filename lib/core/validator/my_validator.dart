class ValidatorUtils {
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Name is required';
    }
    if (!RegExp(r'^[A-Za-z ]{5,}$').hasMatch(name)) {
      return 'Enter a valid name (at least 5 letters)';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*)(_+؟/\\|]).{8,}$').hasMatch(password)) {
      return 'Password must be at least 8 characters, include upper and lower case, number, and special character';
    }
    return null;
  }
  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+20(10|11|12|15)\d{8}$').hasMatch(phone)) {
      return 'Enter a valid Egyptian phone number';
    }
    return null;
  }
}