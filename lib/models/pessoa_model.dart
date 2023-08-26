
import 'package:autom_v3/models/model.dart';

class PessoaModel
        extends Model<dynamic>
{
    PessoaModel()
    {
        super.tableName = 'at_pessoa';
        super.primaryKey = 'id';
    }
}