import 'package:flutter/material.dart';
import 'package:introducao_flutter/model.dart';

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  Pessoa({this.nome, this.cpf, this.nascimento, this.sexo});
}

class NotaFiscal {
  int? numero;
  DateTime? emissao;
  Pessoa? cliente;
  String? enderecoEntrega;
  List<ItemNF> listaItens = [];

  NotaFiscal({this.numero, this.emissao, this.cliente, this.enderecoEntrega});

  double calcularValorTotal() {
    double total = 0.0;
    for (ItemNF item in listaItens) {
      total += item.getValorTotal();
    }
    return total;
  }

  double calcularTotalDescontos() {
    double desconto = 0.0;
    for (ItemNF item in listaItens) {
      desconto += item.desconto;
    }
    return desconto;
  }

  // double calcularTotalAcrescimos(){}

  ItemNF? getProdutoMaisBarato() {
    ItemNF? maisBarato;
    for (ItemNF item in listaItens) {
      if (maisBarato == null) {
        maisBarato = item;
      }
      else if (item.getValorTotal() < maisBarato.getValorTotal()) {
        maisBarato = item;
      }
    }
    return maisBarato;
  }

  ItemNF? getProdutoMaisCaro() {
    ItemNF? maisCaro;
    for (ItemNF item in listaItens) {
      if (maisCaro == null) {
        maisCaro == item;
      }
      else if (item.getValorTotal() > maisCaro.getValorTotal()) {
        maisCaro = item;
      }
    }
    return maisCaro;
  }

  ItemNF addItem(
      {required String produto, required double valor, double desconto = 0.0, double acrescimo = 0.0}) {
    ItemNF item = ItemNF(
        numSeq: listaItens.length + 1,
        produto: produto,
        valor: valor,
        desconto: desconto,
        acrescimo: acrescimo
    );
    listaItens.add(item);
    return item;
  }

}

class ItemNF {
  int numSeq;
  String produto;
  double valor;
  double desconto;
  double acrescimo;

  ItemNF(
      {required this.numSeq, required this.produto, required this.valor, this.desconto = 0.0, this.acrescimo = 0.0});

  double getValorTotal() => valor + acrescimo - desconto;

  @override
  String toString() {
    return '{numSeq=$numSeq, produto=$produto, valor=$valor, desconto=$desconto, acrescimo=$acrescimo, valorTotal=${getValorTotal()}}';
  }
}

void mainNotaFiscal() {
  final pessoa = Pessoa(nome: 'Reginaldo');


  final nota = NotaFiscal(cliente: pessoa,
      emissao: DateTime(2022, 1, 1),
      enderecoEntrega: "Rua 7 de Setembro, 1600",
      numero: 133);
  nota.cliente = pessoa;
  nota.addItem(produto: 'Notebook', valor: 1000.0);
  nota.addItem(produto: 'Monitor', valor: 500.0, acrescimo: 20);
  nota.addItem(produto: 'Mouse', valor: 100);

  print('Valor total da NF = ${nota.calcularValorTotal()}');
  print('Produto mais barato = ${nota.getProdutoMaisBarato()}');
}