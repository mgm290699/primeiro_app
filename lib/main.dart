import 'package:flutter/material.dart';

void main() => runApp(abranapp());

class abranapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: ListaTransferencias(),
    ),
  );
  }
}

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transferência'), backgroundColor: Color.fromARGB(99, 49, 49, 49),),
      body: Column(
        children: [
          Editor(controlador: _controladorCampoNumeroConta, dica: '0000', rotulo: 'Número da conta',),
          Editor(controlador: _controladorCampoValor, dica: '0.00', rotulo: 'Valor', icone: Icons.monetization_on,),
          ElevatedButton(
            onPressed: () => _criaTransferencia(_controladorCampoNumeroConta, _controladorCampoValor, context),
            child: Text('Confirmar'),
            ),
        ],
      ));
  }
}

void _criaTransferencia(_controladorCampoNumeroConta, _controladorCampoValor, BuildContext context){
  final int? numeroConta = 
    int.tryParse(_controladorCampoNumeroConta.text);
  final double? valor = 
    double.tryParse(_controladorCampoValor.text);
  
  if (numeroConta != null && valor != null) {
    final transferenciaCriada = Transferencia(valor, numeroConta);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transferência feita com sucesso'),
      ),
    );
    Navigator.pop(context, transferenciaCriada); 
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Não foi possível realizar a transferência'),
      )
    );
  }
}


class Editor extends StatelessWidget {

  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controlador,
              style: TextStyle(
                fontSize: 24.0
              ),
              decoration: InputDecoration(
                icon: icone != null ? Icon(icone) : null,
                labelText: rotulo,
                hintText: dica,
              ),
            ),
          );
  }
}


class ListaTransferencias extends StatelessWidget {
  Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text('ABRANApp', style: TextStyle(color: Colors.white), ), 
      backgroundColor: Color.fromARGB(255, 100, 0, 109),
    ),
    body: Column(
          children: [
            ItemTransferencia(Transferencia(100.0, 31321)),
            ItemTransferencia(Transferencia(3100.0, 7818)),
            ItemTransferencia(Transferencia(100.0, 3118)),
          ],
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

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context){
    return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(_transferencia.valor.toString()),
              subtitle: Text(_transferencia.numeroConta.toString()),
            )
          );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
      return 'Transferencia {valor: $valor, numeroConta: $numeroConta}';
  }

}