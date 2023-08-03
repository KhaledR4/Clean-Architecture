class ApiEndpoints{
  static const String base = "http://localhost:5000/api/";
  static const String signUp = "${base}signup/post";
  static String checkTokenValidation(token) => "${base}sigin/token?token=$token";
  static String checkUserCredentials(email, password) => "${base}signin/login?email=$email&password=$password";
}
