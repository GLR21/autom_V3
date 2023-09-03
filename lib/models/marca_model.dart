import 'package:autom_v3/models/model.dart';

class MarcaModel extends Model<dynamic>
{
    MarcaModel()
    {
        super.tableName = 'at_marca';
        super.primaryKey = 'id';
    }
}