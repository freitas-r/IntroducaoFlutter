import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
    return listaItens
        .map((item) => item.getValorTotal())
        .reduce((a, b) => a + b);
  }

  double calcularTotalDescontos() {
    return listaItens.map((item) => item.desconto).reduce((a, b) => a + b);
  }

  double calcularTotalAcrescimos() {
    return listaItens.map((item) => item.acrescimo).reduce((a, b) => a + b);
  }

  ItemNF getProdutoMaisBarato() {
    return listaItens
        .reduce((a, b) => a.getValorTotal() < b.getValorTotal() ? a : b);
  }

  ItemNF getProdutoMaisCaro() {
    return listaItens
        .reduce((a, b) => a.getValorTotal() > b.getValorTotal() ? a : b);
  }

  bool possuiDesconto() {
    return listaItens.map((item) => item.desconto).any((a) => a > 0);
  }

  Iterable<ItemNF> itensComDesconto() {
    return listaItens.map((item) => item).where((item) => item.desconto > 0);
  }

  ItemNF addItem(
      {required String produto,
      required double valor,
      double desconto = 0.0,
      double acrescimo = 0.0}) {
    if (valor == 0.0) {
      throw Exception('O valor não pode ser zero');
    }
    if (produto == '') {
      throw Exception('Produto precisa ser informado');
    }
    ItemNF item = ItemNF(
        numSeq: listaItens.length + 1,
        produto: produto,
        valor: valor,
        desconto: desconto,
        acrescimo: acrescimo);
    listaItens.add(item);
    return item;
  }

  String getStrItens() {
    return listaItens.map((i) => "${i.numSeq}: ${i.produto}").join(", ");
  }
}

class ItemNF {
  int numSeq;
  String produto;
  double valor;
  double desconto;
  double acrescimo;

  ItemNF(
      {required this.numSeq,
      required this.produto,
      required this.valor,
      this.desconto = 0.0,
      this.acrescimo = 0.0});

  double getValorTotal() => valor + acrescimo - desconto;

  @override
  String toString() {
    return '{numSeq=$numSeq, produto=$produto, valor=$valor, desconto=$desconto, acrescimo=$acrescimo, valorTotal=${getValorTotal()}}';
  }
}

void mainNotaFiscal() {
  final pessoa = Pessoa(nome: 'Reginaldo');
  final nota = NotaFiscal(
      cliente: pessoa,
      emissao: DateTime(2022, 1, 1),
      enderecoEntrega: "Rua 7 de Setembro, 1600",
      numero: 133);
  nota.cliente = pessoa;
  nota.addItem(produto: 'Notebook', valor: 1000.0, desconto: 50);
  nota.addItem(produto: 'Monitor', valor: 500.0, acrescimo: 20);
  nota.addItem(produto: 'Mouse', valor: 100, desconto: 10);
  nota.addItem(produto: 'Mouse', valor: 50.0);
  double valorTotal = nota.calcularValorTotal();
  print('Valor total da NF = $valorTotal');
  print('Produto mais barato = ${nota.getProdutoMaisBarato().produto}');
  print('Produto mais caro = ${nota.getProdutoMaisCaro().produto}');
  if (nota.possuiDesconto()) {
    print('oi');
  }
  print(nota.itensComDesconto());
}
