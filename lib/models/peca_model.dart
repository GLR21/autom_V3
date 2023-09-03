import 'package:autom_v3/models/model.dart';

class PecaModel extends Model<dynamic>
{
    PecaModel()
    {
        super.tableName = 'at_peca';
        super.primaryKey = 'id';
    }
}