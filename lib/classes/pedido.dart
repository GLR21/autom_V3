
// ignore_for_file: unnecessary_getters_setters, prefer_null_aware_operators
import 'package:autom_v3/classes/pedido_peca.dart';
import 'package:autom_v3/classes/pessoa.dart';

class Pedido
    extends
        Object
{
    static const int statusCancelado    = 1;
    static const int statusPendente     = 2;
    static const int statusConcluido    = 3;

    int _id = 0;
    num _total = 0.0;
    int _status = Pedido.statusPendente;
    String? _dtAbertura;
    String? _dtEncerramento;
    String? _dtReabertura;
    String? _dtCancelamento;
    String _cep = '';
    String _rua = '';
    String _bairro = '';
    String _numeroEndereco = '';
    int? _refCidade;
    bool _flUsarEnderecoCliente = false;
    Pessoa? _refCliente;

    List<PedidoPeca> _pecasPedido = [];

    Pedido
    (
        num total,
        int status,
        String cep,
        String rua,
        String bairro,
        String numeroEndereco,
        int refCidade,
        bool flUsarEnderecoCliente,
        [
            int id = 0,
            String? dtAbertura ,
            String? dtEncerramento,
            String? dtReabertura,
            String? dtCancelamento,
            List<PedidoPeca>? pecasPedido,
            Pessoa? refCliente
        ]
    )
    {
        _total = total;
        _status = status;
        _dtAbertura = dtAbertura;
        _cep = cep;
        _rua = rua;
        _bairro = bairro;
        _numeroEndereco = numeroEndereco;
        _refCidade = refCidade;
        _flUsarEnderecoCliente = flUsarEnderecoCliente;
        _id = id;
        _dtEncerramento = dtEncerramento;
        _dtReabertura = dtReabertura;
        _dtCancelamento = dtCancelamento;
        _pecasPedido = pecasPedido ?? [];
        _refCliente = refCliente;
    }

    Pedido.empty();

    Pedido.byId
    (
        this._id
    );

    int get id => _id;
    num get total => _total;
    int get status => _status;
    String? get dtAbertura => _dtAbertura;
    String? get dtEncerramento => _dtEncerramento;
    String? get dtReabertura => _dtReabertura;
    String? get dtCancelamento => _dtCancelamento;
    String get cep => _cep;
    String get rua => _rua;
    String get bairro => _bairro;
    String get numeroEndereco => _numeroEndereco;
    int? get refCidade => _refCidade;
    bool get flUsarEnderecoCliente => _flUsarEnderecoCliente;
    List<PedidoPeca> get pecasPedido => _pecasPedido;
    Pessoa? get refCliente => _refCliente;

    set id(int id)
    {
        _id = id;
    }
    set status(int status)
    {
        _status = status;
    }
    set total(num total)
    {
        _total = total;
    }
    set dtAbertura(String? dtAbertura)
    {
        _dtAbertura = dtAbertura;
    }
    set dtEncerramento(String? dtEncerramento)
    {
        _dtEncerramento = dtEncerramento;
    }
    set dtReabertura(String? dtReabertura)
    {
        _dtReabertura = dtReabertura;
    }
    set dtCancelamento(String? dtCancelamento)
    {
        _dtCancelamento = dtCancelamento;
    }
    set cep(String cep)
    {
        _cep = cep;
    }
    set rua(String rua)
    {
        _rua = rua;
    }
    set bairro(String bairro)
    {
        _bairro = bairro;
    }
    set numeroEndereco(String numeroEndereco)
    {
        _numeroEndereco = numeroEndereco;
    }
    set refCidade( int? refCidade)
    {
        _refCidade = refCidade;
    }
    set flUsarEnderecoCliente(bool flUsarEnderecoCliente)
    {
        _flUsarEnderecoCliente = flUsarEnderecoCliente;
    }

    set refCliente(Pessoa? refCliente)
    {
        _refCliente = refCliente;
    }

    void addPecaPedido( PedidoPeca pecaPedido )
    {
        _pecasPedido.add( pecaPedido );
    }

    void removePecaPedido( PedidoPeca pecaPedido )
    {
        _pecasPedido.remove( pecaPedido );
    }

    void clearPecaPedido()
    {
        _pecasPedido.clear();
    }

    Map<String, dynamic> toMap()
    {
        return 
        {
            'id': _id,
            'total': _total,
            'status': _status,
            'dt_abertura': _dtAbertura,
            'dt_encerramento': _dtEncerramento,
            'dt_reabertura': _dtReabertura,
            'dt_cancelamento': _dtCancelamento,
            'cep': _cep,
            'rua': _rua,
            'bairro': _bairro,
            'numero_endereco': numeroEndereco,
            'ref_cidade': _refCidade,
            'fl_usar_endereco_cliente': flUsarEnderecoCliente
        };
    }
    
    Pedido toObject(Map<String, dynamic> map)
    {
        return Pedido
        (
            num.parse(map['total']),
            map['status'],
            map['cep'],
            map['rua'],
            map['bairro'],
            map['numero_endereco'],
            map['ref_cidade'],
            map['fl_usar_endereco_cliente'],
            map['id'],
            map['dt_abertura'],
            map['dt_encerramento'],
            map['dt_reabertura'],
            map['dt_cancelamento'],
            map['pedidos_pecas'] != null ? map['pedidos_pecas'].map<PedidoPeca>((e) => PedidoPeca(e['ref_pedido'], e['ref_peca'], e['quantidade'])).toList() : null,
            map['ref_cliente'] as Pessoa
        );
    }

    @override
    String toString()
    {
        return 'Pedido{_id: $_id, _total: $_total, _status: $_status, _dtAbertura: $_dtAbertura, _dtEncerramento: $_dtEncerramento, _dtReabertura: $_dtReabertura, _dtCancelamento: $_dtCancelamento, _cep: $_cep, _rua: $_rua, _bairro: $_bairro, _numeroEndereco: $_numeroEndereco, _refCidade: $_refCidade, _flUsarEnderecoCliente: $_flUsarEnderecoCliente, _refCliente: $_refCliente, _pecasPedido: $_pecasPedido}';
    }
}