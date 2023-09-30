
// ignore_for_file: unnecessary_getters_setters

import 'package:autom_v3/classes/cidade.dart';

class Pedido
    extends
        Object
{
    int _id = 0;
    num _total = 0.0;
    int _status = 0;
    DateTime? _dtAbertura = DateTime.now();
    DateTime? _dtEncerramento = DateTime.now();
    DateTime? _dtReabertura = DateTime.now();
    DateTime? _dtCancelamento = DateTime.now();
    String _cep = '';
    String _rua = '';
    String _bairro = '';
    String _numeroEndereco = '';
    Cidade _refCidade = Cidade.empty();
    bool _flUsarEnderecoCliente = false;

    Pedido.empty();

    Pedido(
        num total,
        int status,
        DateTime? dtAbertura,
        DateTime? dtEncerramento,
        DateTime? dtReabertura,
        DateTime? dtCancelamento,
        String cep,
        String rua,
        String bairro,
        String numeroEndereco,
        Cidade refCidade,
        bool flUsarEnderecoCliente,
        [int id = 0]
    )
    {
        _total = total;
        _status = status;
        _dtAbertura = dtAbertura;
        _dtEncerramento = dtEncerramento;
        _dtReabertura = dtReabertura;
        _dtCancelamento = dtCancelamento;
        _cep = cep;
        _rua = rua;
        _bairro = bairro;
        _numeroEndereco = numeroEndereco;
        _refCidade = refCidade;
        _flUsarEnderecoCliente = flUsarEnderecoCliente;
        _id = id;
    }

    int get id => _id;
    num get total => _total;
    int get status => _status;
    DateTime? get dtAbertura => _dtAbertura;
    DateTime? get dtEncerramento => _dtEncerramento;
    DateTime? get dtReabertura => _dtReabertura;
    DateTime? get dtCancelamento => _dtCancelamento;
    String get cep => _cep;
    String get rua => _rua;
    String get bairro => _bairro;
    String get numeroEndereco => _numeroEndereco;
    Cidade get refCidade => _refCidade;
    bool get flUsarEnderecoCliente => _flUsarEnderecoCliente;

    set id(int id)
    {
        _id = id;
    }
    set total(num total)
    {
        _total = total;
    }
    set dtAbertura(DateTime? dtAbertura)
    {
        _dtAbertura = dtAbertura;
    }
    set dtEncerramento(DateTime? dtEncerramento)
    {
        _dtEncerramento = dtEncerramento;
    }
    set dtReabertura(DateTime? dtReabertura)
    {
        _dtReabertura = dtReabertura;
    }
    set dtCancelamento(DateTime? dtCancelamento)
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
    set refCidade(Cidade refCidade)
    {
        _refCidade = refCidade;
    }
    set flUsarEnderecoCliente(bool flUsarEnderecoCliente)
    {
        _flUsarEnderecoCliente = flUsarEnderecoCliente;
    }

    Map<String, dynamic> toMap()
    {
        return 
        {
            'id': _id,
            'total': _total,
            'dt_abertura': _dtAbertura,
            'dt_encerramento': _dtEncerramento,
            'dt_reabertura': _dtReabertura,
            'dt_cancelamento': _dtCancelamento,
            'cep': _cep,
            'rua': _rua,
            'bairro': _bairro,
            'numero_endereco': numeroEndereco,
            'ref_cidade': refCidade.id,
            'fl_usar_endereco_cliente': flUsarEnderecoCliente
        };
    }

    @override
    String toString()
    {
        return 'Marcas{id: $_id, total: $_total, cep: $_cep, rua: $_rua, bairro: $_bairro, numero_endereco: $_numeroEndereco, cidade: $_refCidade}';
    }

    Pedido toObject(Map<String, dynamic> map)
    {
        return Pedido(
            num.parse(map['total']),
            map['status'],
            map['dt_abertura'],
            map['dt_encerramento'],
            map['dt_reabertura'],
            map['dt_cancelamento'],
            map['cep'],
            map['rua'],
            map['bairro'],
            map['numero_endereco'],
            Cidade.byId(map['ref_cidade']),
            map['fl_usar_endereco_cliente'],
            map['id'],
        );
    }
}