import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _contador = 0;
  bool _incrementando = true;
  List<int> _historico = [];
  int _somaTotal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Correios'),
      ),
      drawer: _buildDrawer(),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementarOuDecrementar,
        tooltip: _incrementando ? 'Incrementar' : 'Decrementar',
        child: Icon(_incrementando ? Icons.add : Icons.remove),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
              child: Text(
                'Número de entregas:',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              )),
          Text(
            '$_contador',
            style: Theme.of(context).textTheme.headline3,
          ),
          const Padding(
              padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
              child: Text(
                'Memória:',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              _historico.isEmpty ? '-' : _historico.join(', '),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(bottom: 30.0, top: 30.0),
              child: Text(
                'Total:',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '$_somaTotal',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'Bem-vindo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.clear),
            title: Text('Zerar Contador'),
            onTap: _zerar,
          ),
          ListTile(
            leading: Icon(Icons.swap_horiz),
            title: Text('Inverter Contador'),
            onTap: _inverter,
          ),
          ListTile(
            leading: Icon(Icons.save_outlined),
            title: Text('Memorizar Contador'),
            onTap: _memorizar,
          ),
        ],
      ),
    );
  }

  void _incrementarOuDecrementar() {
    setState(() {
      if (_incrementando) {
        _contador++;
      } else {
        _contador--;
      }
    });
  }

  void _zerar() {
    Navigator.of(context).pop();
    setState(() {
      _contador = 0;
      _historico.clear();
      _somaTotal = 0;
    });
  }

  void _inverter() {
    Navigator.of(context).pop();
    setState(() {
      _incrementando = !_incrementando;
    });
  }

  void _memorizar() {
    Navigator.of(context).pop();
    setState(() {
      _historico.add(_contador);
      _somaTotal = _historico.isEmpty ? _somaTotal = 0 : _historico.reduce((a, b) => a + b);
    });
  }


}
