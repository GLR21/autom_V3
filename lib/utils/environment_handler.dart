import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentHandler
{
    static const viaCepURL = 'VIA_CEP_CALL_CEP';

    static String get(String key)
    {
        return dotenv.get(key);
    }
}