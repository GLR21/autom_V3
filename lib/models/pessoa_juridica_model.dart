import 'package:autom_v3/models/model.dart';

class PessoaJuridicaModel
    extends Model<dynamic>
{
    PessoaJuridicaModel()
    {
        super.tableName = 'at_pessoa_juridica';
        super.primaryKey = 'ref_pessoa';
    }
}