// ignore_for_file: prefer_null_aware_operators

import 'package:autom_v3/classes/peca.dart';
import 'package:autom_v3/classes/pedido.dart';
import 'package:autom_v3/classes/pedido_peca.dart';
import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/controllers/peca_controller.dart';
import 'package:autom_v3/controllers/pedido_controller.dart';
import 'package:autom_v3/controllers/pessoa_controller.dart';
import 'package:autom_v3/models/pedido_model.dart';
import 'package:autom_v3/models/pedido_peca_model.dart';
import 'package:autom_v3/models/pedido_pessoa_model.dart';
import 'package:autom_v3/models/pessoa_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async
{
    await dotenv.load(fileName: ".env");

    try
    {
        // List<dynamic> pedido = await PedidoModel().select( 
        //     {
        //         'id': 19
        //     }
        // );

        // Map<String, dynamic > pedidoReturn = pedido.first;

        // List<dynamic> pedidosPecas = await PedidoPecaModel().select( { 'ref_pedido': pedidoReturn['id'] } );
        // List<dynamic> pedidoCliente = await PedidoPessoaModel().select( { 'ref_pedido': pedidoReturn['id'] } );

        // // print( pedidoCliente.first );

        // List<PedidoPeca> pedidosPecasList = [];

        // for (var element in pedidosPecas)
        // {
        //     pedidosPecasList.add( PedidoPeca( element['ref_pedido'], element['ref_peca'], element['quantidade'] ) );
        // }


        // Pedido pedidoObj = Pedido
        // (
        //     num.parse( pedidoReturn['total'] ),
        //     pedidoReturn['status'],
        //     pedidoReturn['cep'],
        //     pedidoReturn['rua'],
        //     pedidoReturn['bairro'],
        //     pedidoReturn['numero_endereco'],
        //     pedidoReturn['ref_cidade'],
        //     pedidoReturn['fl_usar_endereco_cliente'],
        //     pedidoReturn['id'],
        //     pedidoReturn['dt_abertura'] == null ? null : pedidoReturn['dt_abertura'].toString(),
        //     pedidoReturn['dt_encerramento'] == null ? null : pedidoReturn['dt_encerramento'].toString(),
        //     pedidoReturn['dt_reabertura'] == null ? null : pedidoReturn['dt_reabertura'].toString(),
        //     pedidoReturn['dt_cancelamento'] == null ? null : pedidoReturn['dt_cancelamento'].toString(),
        //     pedidosPecasList,
        //     pedidoCliente.first['ref_pessoa']
        // );

        // Pedido pedidoObj = await PedidoController().getPedido( Pedido.byId( 19 ) );

        // print(pedidoObj);

        // pedidoObj.status = Pedido.statusPendente;

        // await PedidoModel().update( pedidoObj.toMap() );
        // List allPedidos = await PedidoController().getAllPedidos();

        // List allPedidos = await PedidoModel().selectAll();

        // print( allPedidos );   
    
        
        // await PedidoController().insert( pedido );

        // List pedidoDadosInsert = await PedidoModel().insert( pedido.toMap() );
        
        // Map<String, dynamic> pedidoInsertReturn = pedidoDadosInsert.first;

        // for (var element in pecasPedido)
        // {
        //     element.refPedido = pedidoInsertReturn['id'];
        //     await PedidoPecaModel().insert( element.toMap() );
        // }

        // await PedidoPessoaModel().insert( { 'ref_pedido': pedidoInsertReturn['id'], 'ref_pessoa': dadosCliente.id } );
        // print( pedidoInsertReturn['id'] );
        // print( 'Pedido inserido com sucesso!' );
        
        Pedido pedido = await PedidoController().getPedido( Pedido.byId( 34 ) );

        // print( pedido.pecasPedido );

        // pedido.clearPecaPedido();

        // print( pedido.pecasPedido );

        // pedido.addPecaPedido( PedidoPeca( pedido.id ,16 , 10) );
        // pedido.addPecaPedido( PedidoPeca( pedido.id ,  17 , 29) );

        // print( pedido.pecasPedido );

        // num total = 0;

        // for (var element in pedido.pecasPedido)
        // {
        //     Peca peca = await PecaController().get( Peca.byId( element.refPeca ) );
        //     total += peca.valorRevenda * element.quantidade;
        // }

        // pedido.total = total;

        // await PedidoController().update( pedido );

        await PedidoController().conclude(pedido);

        
    }
    catch(e )
    {
        print(e);
    }
}
