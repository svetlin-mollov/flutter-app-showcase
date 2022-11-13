import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : username = '',
        password = '',
        _isLoginEnabled = false;

  /// Used for the copyWith method
  LoginPresentationModel._(
    this.username,
    this.password,
    this._isLoginEnabled,
  );

  final String username;
  final String password;
  final bool _isLoginEnabled;

  @override
  bool get isLoginEnabled => _isLoginEnabled;

  LoginPresentationModel copyWith({
    String? username,
    String? password,
    bool? isLoginEnabled,
  }) {
    return LoginPresentationModel._(
      username ?? this.username,
      password ?? this.password,
      isLoginEnabled ?? _isLoginEnabled,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
}
