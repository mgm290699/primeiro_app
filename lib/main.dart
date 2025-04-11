import 'package:flutter/material.dart';

void main() => runApp(abranapp());

class abranapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: FormularioTransferencia(),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorCampoNumeroConta,
              style: TextStyle(
                fontSize: 24.0
              ),
              decoration: InputDecoration(
                labelText: 'Número da Conta',
                hintText: '0000-X'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorCampoValor,
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: '0.00',
                hintText: '100'
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
              final double? valor = double.tryParse(_controladorCampoValor.text);
              if(numeroConta != null && valor != null){
                final transferenciaCriada = Transferencia(valor, numeroConta);
                print('Resultado: $transferenciaCriada');
              }
              else{
                print('Valor invalido');
              }
            },
            child: Text('Confirmar'),
            ),
        ],
      ));
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
          onPressed: () {},
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