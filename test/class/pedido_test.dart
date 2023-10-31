import 'package:autom_v3/classes/cidade.dart';
import 'package:autom_v3/classes/pedido.dart';
import 'package:autom_v3/models/pedido_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async
{
    await dotenv.load(fileName: ".env");

    try
    {
        List<dynamic> pedido = await PedidoModel().select( 
            {
                'id': 19
            }
        );

        Pedido pedidoObj = Pedido.empty().toObject(pedido.first);
        print(pedidoObj);

        Pedido newPedido = Pedido(
            221.0,
            0,
            DateTime.parse('2023-04-09'),
            DateTime.parse('2023-04-09'),
            DateTime.parse('2023-04-09'),
            DateTime.parse('2023-04-09'),
            '95900-000',
            'Rua Teste',
            'Bairro Teste',
            'Número Teste',
            Cidade.byId(1),
            false
        );

        PedidoModel().insert(newPedido.toMap());

    }
    catch(e)
    {
        print(e);
    }
}
