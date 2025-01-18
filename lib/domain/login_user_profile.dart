class LoginUserProfile {
  String userIc;
  String userName;
  String userGender;
  int userAge;
  String userEmail;
  String userPassword;
  String userConfirmedPassword;
  String userRole;

  // Constructor to initialize the user profile with all required fields.
  LoginUserProfile({
    required this.userIc,
    required this.userName,
    required this.userGender,
    required this.userAge,
    required this.userEmail,
    required this.userPassword,
    required this.userConfirmedPassword,
    required this.userRole,
  });

  // create a LoginUserProfile object from a map of data.
  factory LoginUserProfile.read(Map<String, dynamic> data) {
    return LoginUserProfile(
      userIc: data['user_ic'] ?? '',  // Default to an empty string if null.
      userName: data['user_name'] ?? '',
      userGender: data['user_gender'] ?? '',
      userAge: data['user_age'] ?? 0,  // Default to 0 if null.
      userEmail: data['user_email'] ?? '',
      userPassword: data['user_password'] ?? '',
      userConfirmedPassword: data['user_confirmedPassword'] ?? '',
      userRole: data['user_role'] ?? '',
    );
  }

  // Method to convert the LoginUserProfile object to a map for storage or serialization.
  Map<String, dynamic> create() {
    return {
      'user_ic': userIc,
      'user_name': userName,
      'user_gender': userGender,
      'user_age': userAge,
      'user_email': userEmail,
      'user_password': userPassword,
      'user_confirmedPassword': userConfirmedPassword,
      'user_role': userRole,
    };
  }
}
