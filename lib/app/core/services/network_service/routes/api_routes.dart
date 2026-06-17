import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoutes {
  ///
  /// Serving url
  ///
  static String get baseUrl => dotenv.get('BASE_URL');
  static String get baseUrl2 => dotenv.get('BASE_URL2');
  // static String get imageUrl => dotenv.get('Image_URL');

  //authentication

  static const login = "/auth/login";
  static const signup = "/auth/register";

  // querys
  static const getCountryCurrency = ''' 
  {
  countries {
    code
    name
    emoji
    capital
    currency
  }
}

  ''';
}
