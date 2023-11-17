// ignore_for_file: unnecessary_getters_setters

class PedidoPeca
    extends
        Object
{
    int _refPedido  = 0;
    int _refPeca    = 0;
    int _quantidade = 0;

    PedidoPeca
    (
        int refPedido,
        int refPeca,
        int quantidade,
    )
    {
        _refPedido = refPedido;
        _refPeca = refPeca;
        _quantidade = quantidade;
    }

    int get refPedido => _refPedido;
    int get refPeca => _refPeca;
    int get quantidade => _quantidade;

    set refPedido(int refPedido)
    {
        _refPedido = refPedido;
    }

    set refPeca(int refPeca)
    {
        _refPeca = refPeca;
    }

    set quantidade(int quantidade)
    {
        _quantidade = quantidade;
    }

    Map<String, dynamic> toMap()
    {
        return
        {
            'ref_pedido': _refPedido,
            'ref_peca': _refPeca,
            'quantidade': _quantidade,
        };
    }

    @override
    String toString()
    {
        return 'PedidoPeca{refPedido: $_refPedido, refPeca: $_refPeca, quantidade: $_quantidade}';
    }
}