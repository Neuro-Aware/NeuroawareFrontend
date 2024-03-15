class ApiEndPoints {
  static final String baseUrl = 'https://a89a-14-194-135-206.ngrok-free.app';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _userEndPoints userEndpoints = _userEndPoints();
}

class _AuthEndPoints {
  // final String test = 'test';
  final String registerEmail = 'auth/register';
  final String loginEmail = 'auth/login';
  final String logoutEmail = 'auth/logout';
}

class _userEndPoints {
  final String getUser = 'user/getme';
  final String updateUser = 'user/updateDetails';
  final String updateImage = 'user/updateImage';
  final String imageGet = 'user/imageGet';
}
