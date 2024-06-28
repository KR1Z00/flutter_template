enum AppError {
  registrationError("An error occurred while registering"),
  signInError("An error occurred while signing in"),
  loadingUserDataError("An error occurred while loading the user's data"),
  notSignedIn("You need to be signed in to perform this operation"),
  invalidJoinCode("Invalid join code"),
  ;

  final String errorDescription;

  const AppError(this.errorDescription);
}
