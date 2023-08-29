import 'package:autom_v3/models/model.dart';

class EstadoModel extends Model<dynamic>
{
    EstadoModel()
    {
        super.tableName = 'at_estado';
        super.primaryKey = 'id';
    }
}