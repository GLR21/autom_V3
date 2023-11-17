import 'package:autom_v3/models/model.dart';

class PedidoPecaModel extends Model<dynamic>
{
    PedidoPecaModel()
    {
        super.tableName = 'at_pedido_peca';
        super.primaryKey = 'ref_pedido';
    }
}