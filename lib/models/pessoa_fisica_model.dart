import 'package:autom_v3/models/model.dart';

class PessoaFisicaModel
        extends Model<dynamic>
{
    PessoaFisicaModel()
    {
        super.tableName = 'at_pessoa_fisica';
        super.primaryKey = 'ref_pessoa';
    }
}