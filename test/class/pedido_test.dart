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
        

        // Map<String, dynamic > pedidoReturn = pedido.first;

        // List<dynamic> pedidosPecas = await PedidoPecaModel().select( { 'ref_pedido': pedidoReturn['id'] } );
        // List<dynamic> pedidoCliente = await PedidoPessoaModel().select( { 'ref_pedido': pedidoReturn['id'] } );

        // // print( pedidoCliente.first );

        List<PedidoPeca> pedidosPecasList = [];

        Peca peca1 = await PecaController().get( Peca.byId( 8 ) );
        Peca peca2 = await PecaController().get( Peca.byId( 9 ) );
        // for (var element in pedidosPecas)
        // {
        //     pedidosPecasList.add( PedidoPeca( element['ref_pedido'], element['ref_peca'], element['quantidade'] ) );
        // }

        pedidosPecasList.add( PedidoPeca( 0, peca1.id, 10 ) );
        pedidosPecasList.add( PedidoPeca( 0, peca2.id, 20 ) );

        double valorTotal = 0;
        
        for (var element in pedidosPecasList)
        {
            Peca peca = await PecaController().get( Peca.byId( element.refPeca ) );
            valorTotal += peca.valorRevenda * element.quantidade;
        }

        Pessoa dadosCliente = await PessoaController().get( Pessoa.byId( 79 ) );

        Pedido pedidoObj = Pedido
        (
            valorTotal,
            Pedido.statusPendente,
            '95914104',
            'Wilma Ruwer',
            'São Cristóvão',
            '123',
            1,
            false,
            0,
            null,
            null,
            null,
            null,
            pedidosPecasList,
            dadosCliente
        );

        // Pedido pedidoObj = await PedidoController().getPedido( Pedido.byId( 19 ) );

        // print(pedidoObj);

        // pedidoObj.status = Pedido.statusPendente;

        // await PedidoModel().update( pedidoObj.toMap() );
        // List allPedidos = await PedidoController().getAllPedidos();

        // List allPedidos = await PedidoModel().selectAll();

        // print( allPedidos );   
    
        
        await PedidoController().insert( pedidoObj );

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
        
        // Pedido pedido = await PedidoController().getPedido( Pedido.byId( 34 ) );

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

        // await PedidoController().conclude(pedido);

        
    }
    catch(e )
    {
        print(e);
    }
}
