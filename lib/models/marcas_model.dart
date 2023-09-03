import 'package:autom_v3/models/model.dart';

class MarcasModel extends Model<dynamic>
{
    MarcasModel()
    {
        super.tableName = 'at_marca';
        super.primaryKey = 'id';
    }
}