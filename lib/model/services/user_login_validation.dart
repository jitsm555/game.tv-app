class UserLogInValidation {
  /// Check user info with some hardcoded credentials, In future it can be
  /// replaced with network request
  bool checkUserInfo(String phoneNumber, String password) {
    switch (phoneNumber) {
      case '9898989898':
      case '9876543210':
        return "password12" == password;
      default:
        return false;
    }
  }
}
