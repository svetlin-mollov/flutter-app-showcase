class ValidateCredentialsUseCase {
  const ValidateCredentialsUseCase();

  bool execute({
    required String username,
    required String password,
  }) {
    return username.isNotEmpty && password.isNotEmpty;
  }
}
