import '../../repository/login_repository.dart';
import 'login_interface.dart';

class LoginPresenter {
  final LoginRepository repository;
  final LoginViewInterface view;

  LoginPresenter(this.repository, this.view);

  void signIn(String email, String password) async {
    try {
      final result = await repository.signIn(email, password);
      if (result['success'] == true) {
        view.onLoginSuccess(result['data']['token']); // Assuming token is inside "data"
      } else {
        view.onLoginError(result['message'] ?? 'Login failed');
      }
    } catch (e) {
      view.onLoginError(e.toString());
    }
  }
}
