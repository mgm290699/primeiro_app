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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transferência'), backgroundColor: Color.fromARGB(99, 49, 49, 49),),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Número da Conta',
              hintText: '0000-X'
            ),
          ),
          TextField(),
          ElevatedButton(
            onPressed: null,
            child: Text('Desativado'),
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

}