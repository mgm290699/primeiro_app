import 'package:flutter/material.dart';

void main() => runApp(AbranApp());

class AbranApp extends StatelessWidget {
  const AbranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: ListaTransferencias()));
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
        backgroundColor: Color.fromARGB(99, 49, 49, 49),
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controladorCampoNumeroConta,
            dica: '0000',
            rotulo: 'Número da conta',
          ),
          Editor(
            controlador: _controladorCampoValor,
            dica: '0.00',
            rotulo: 'Valor',
            icone: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed:
                () => _criaTransferencia(
                  _controladorCampoNumeroConta,
                  _controladorCampoValor,
                  context,
                ),
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

void _criaTransferencia(
  TextEditingController controladorCampoNumeroConta,
  TextEditingController controladorCampoValor,
  BuildContext context,
) {
  final int? numeroConta = int.tryParse(controladorCampoNumeroConta.text);
  final double? valor = double.tryParse(controladorCampoValor.text);

  if (numeroConta != null && valor != null) {
    final transferenciaCriada = Transferencia(valor, numeroConta);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Transferência feita com sucesso')));
    Navigator.pop(context, transferenciaCriada);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Não foi possível realizar a transferência')),
    );
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  const Editor({
    super.key,
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ABRANApp', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 100, 0, 109),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          );

          future.then((transferenciaRecebida) {
            if (transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
              debugPrint('Transferência recebida: $transferenciaRecebida');
            } else {
              debugPrint('O formulário foi cancelado ou inválido.');
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferência {valor: $valor, númeroConta: $numeroConta}';
  }
}
