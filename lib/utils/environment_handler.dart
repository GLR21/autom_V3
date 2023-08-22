import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentHandler
{

  static String get(String key)
  {
    return dotenv.get(key);
  }
}