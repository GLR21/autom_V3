// ignore_for_file: prefer_null_aware_operators

import 'package:autom_v3/classes/pedido.dart';
import 'package:autom_v3/classes/pedido_peca.dart';
import 'package:autom_v3/classes/pessoa.dart';
import 'package:autom_v3/controllers/pessoa_controller.dart';
import 'package:autom_v3/models/pedido_model.dart';
import 'package:autom_v3/models/pedido_peca_model.dart';
import 'package:autom_v3/models/pedido_pessoa_model.dart';

class PedidoController
{
    Future<Pedido> getPedido( Pedido pedido ) async
    {
        List dadosPedido = await PedidoModel().select( pedido.toMap() );
        
        if( dadosPedido.isEmpty )
        {
            return Pedido.empty();
        }
        
        Map<String, dynamic> dadosPedidoMap = dadosPedido.first;

        List pedidosPecas = await PedidoPecaModel().select( { 'ref_pedido': dadosPedidoMap['id'] } );
        List<PedidoPeca> pedidosPecasList = [];
        for (var element in pedidosPecas)
        {
            pedidosPecasList.add( PedidoPeca( element['ref_pedido'], element['ref_peca'], element['quantidade'] ) );
        }

        List pedidoPessoaList = await PedidoPessoaModel().select( { 'ref_pedido': dadosPedidoMap['id'] } );
        Map<String, dynamic> pedidoPessoaMap = pedidoPessoaList.first;
        Pessoa pedidoPessoa = await PessoaController().get( Pessoa.byId( pedidoPessoaMap['ref_pessoa'] ) );
        
        pedido = Pedido
        (
            num.parse( dadosPedidoMap['total'] ),
            dadosPedidoMap['status'],
            dadosPedidoMap['cep'],
            dadosPedidoMap['rua'],
            dadosPedidoMap['bairro'],
            dadosPedidoMap['numero_endereco'],
            dadosPedidoMap['ref_cidade'],
            dadosPedidoMap['fl_usar_endereco_cliente'],
            dadosPedidoMap['id'],
            dadosPedidoMap['dt_abertura'] == null ? null : dadosPedidoMap['dt_abertura'].toString(),
            dadosPedidoMap['dt_encerramento'] == null ? null : dadosPedidoMap['dt_encerramento'].toString(),
            dadosPedidoMap['dt_reabertura'] == null ? null : dadosPedidoMap['dt_reabertura'].toString(),
            dadosPedidoMap['dt_cancelamento'] == null ? null : dadosPedidoMap['dt_cancelamento'].toString(),
            pedidosPecasList,
            pedidoPessoa
        );

        return pedido;
    }

    Future<List<Pedido>> getAllPedidos() async
    {
        List dadosPedidos = await PedidoModel().selectAll();
        List<Pedido> pedidos = [];

        for (var element in dadosPedidos)
        {
            pedidos.add( await getPedido( Pedido.byId( element['id'] ) ) );
        }

        return pedidos;
    }

    Future<List<Pedido>> getAllPedidosByCliente( Pessoa cliente ) async
    {
        List dadosPedidos = await PedidoModel().select( { 'ref_cliente': cliente.id } );

        List<Pedido> pedidos = [];

        for (var element in dadosPedidos)
        {
            pedidos.add( await getPedido( Pedido.byId( element['id'] ) ) );
        }

        return pedidos;
    }

    Future<List<Pedido>> getAllPedidosByStatus( int status ) async
    {
        List dadosPedidos = await PedidoModel().select( { 'status': status } );

        List<Pedido> pedidos = [];

        for (var element in dadosPedidos)
        {
            pedidos.add( await getPedido( Pedido.byId( element['id'] ) ) );
        }

        return pedidos;
    }

    Future<void> insert( Pedido pedido ) async
    {
        List pedidoInsertReturn = await PedidoModel().insert( pedido.toMap() );

        pedido.id = pedidoInsertReturn.first['id'];

        for (var element in pedido.pecasPedido)
        {
            element.refPedido = pedido.id;
            await PedidoPecaModel().insert( element.toMap() );
        }

        await PedidoPessoaModel().insert( { 'ref_pedido': pedido.id, 'ref_pessoa': pedido.refCliente?.id } );

        return;
    }

    Future<void> update( Pedido pedido ) async
    {
        await PedidoModel().update( pedido.toMap() );

        await PedidoPecaModel().delete( { 'ref_pedido': pedido.id } );
        for (var element in pedido.pecasPedido)
        {
            await PedidoPecaModel().insert( element.toMap() );
        }

        await PedidoPessoaModel().update( { 'ref_pedido': pedido.id, 'ref_pessoa': pedido.refCliente?.id } );

        return;
    }

    Future<void> conclude( Pedido pedido ) async
    {
        Pedido pedidoDados = await getPedido( Pedido.byId( pedido.id ) );
        pedidoDados.status = Pedido.statusConcluido;
        pedidoDados.dtEncerramento = DateTime.now().toUtc().toString();
        pedidoDados.dtCancelamento = null;
        await update( pedidoDados );
        return;
    }

    Future<void> cancel( Pedido pedido ) async
    {
        Pedido pedidoDados = await getPedido( Pedido.byId( pedido.id ) );
        pedidoDados.status = Pedido.statusCancelado;
        pedidoDados.dtCancelamento = DateTime.now().toUtc().toString();
        pedidoDados.dtEncerramento = null;
        await update( pedidoDados );
        return;
    }

    Future<void> reopen( Pedido pedido ) async
    {
        Pedido pedidoDados = await getPedido( Pedido.byId( pedido.id ) );
        pedidoDados.status = Pedido.statusPendente;
        pedidoDados.dtReabertura = DateTime.now().toUtc().toString();
        pedidoDados.dtCancelamento = null;
        await update( pedidoDados );
        return;
    }
}