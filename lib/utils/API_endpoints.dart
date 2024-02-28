class ApiEndPoints {
  static final String baseUrl =
      'https://fbea-2402-3a80-8df-c07d-b822-789-7a2d-9199.ngrok-free.app';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String test = 'test';
  final String registerEmail = 'auth/register';
  final String loginEmail = 'auth/login';
}
