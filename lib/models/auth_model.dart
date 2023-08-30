
import 'package:autom_v3/models/model.dart';

class AuthModel
    extends Model<dynamic>
{
    AuthModel()
    {
        super.tableName = 'auth';
        super.primaryKey = 'id';
    }    
}