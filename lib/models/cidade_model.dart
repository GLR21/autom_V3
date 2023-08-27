import 'package:autom_v3/models/model.dart';

class CidadeModel extends Model<dynamic>
{
     CidadeModel()
    {
        super.tableName = 'at_cidade';
        super.primaryKey = 'id';
    }
}