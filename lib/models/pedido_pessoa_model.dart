import 'package:autom_v3/models/model.dart';

class PedidoPessoaModel extends Model<dynamic>
{
    PedidoPessoaModel()
    {
        super.tableName = 'at_pedidos_pessoa';
        super.primaryKey = 'ref_pedido';
    }
}