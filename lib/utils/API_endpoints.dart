class ApiEndPoints {
  static final String baseUrl = 'https://5679-47-247-150-6.ngrok-free.app';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  // final String test = 'test';
  final String registerEmail = 'auth/register';
  final String loginEmail = 'auth/login';
  final String logoutEmail = 'auth/logout';
}
