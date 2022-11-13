import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  )   : username = '',
        password = '',
        loginResult = const FutureResult.empty(),
        _isLoginEnabled = false;

  /// Used for the copyWith method
  LoginPresentationModel._(
    this.username,
    this.password,
    this.loginResult,
    this._isLoginEnabled,
  );

  final String username;
  final String password;
  final FutureResult<Either<LogInFailure, User>> loginResult;
  final bool _isLoginEnabled;

  @override
  bool get isLoginEnabled => _isLoginEnabled;

  @override
  bool get isLoading => loginResult.isPending();

  LoginPresentationModel copyWith({
    String? username,
    String? password,
    FutureResult<Either<LogInFailure, User>>? loginResult,
    bool? isLoginEnabled,
  }) {
    return LoginPresentationModel._(
      username ?? this.username,
      password ?? this.password,
      loginResult ?? this.loginResult,
      isLoginEnabled ?? _isLoginEnabled,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoginEnabled;
  bool get isLoading;
}
