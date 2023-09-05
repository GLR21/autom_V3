import 'package:autom_v3/models/model.dart';

class PedidoModel extends Model<dynamic>
{
    PedidoModel()
    {
        super.tableName = 'at_pedido';
        super.primaryKey = 'id';
    }
}