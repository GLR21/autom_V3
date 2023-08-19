import 'package:flutter_dotenv/flutter_dotenv.dart';

class Util
{

  static String? getEnvirommentVariable( String key )
  {
    return dotenv.env[key];
  }
}