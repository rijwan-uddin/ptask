
abstract class LoginViewInterface {
  void onLoginSuccess(String token, String userId); // Update with both parameters
  void onLoginError(String error);
}
