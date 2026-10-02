import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  ///
  /// Serving url
  ///
  static String get baseUrl => dotenv.get('BASE_URL');

  // Authentication - OAuth2 Client Credentials
  static const login =
      "/auth2/oauth/token?grant_type=client_credentials&scope=open";
}
