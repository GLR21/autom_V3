import 'package:autom_v3/models/model.dart';

class PecasModel extends Model<dynamic>
{
    PecasModel()
    {
        super.tableName = 'at_peca';
        super.primaryKey = 'id';
    }
}