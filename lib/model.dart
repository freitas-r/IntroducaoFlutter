
enum Sexo {Masculino, Feminino}

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  Sexo? sexo;

  int? getIdade(){
    if(nascimento == null){
      return null;
    }
    final hoje = DateTime.now();
    final idade = hoje.difference(nascimento!);
    return idade.inDays ~/ 365;
  }

  @override
  String toString() {
    return "nome=$nome, cpf=$cpf, nascimento=$nascimento, idade=${getIdade()}, sexo=$sexo";
  }
}

class Programador extends Pessoa{
  double? salario;
  @override
  String toString(){
    return "nome=$nome, cpf=$cpf, nascimento=$nascimento, idade=${getIdade()}, sexo=$sexo, salário=$salario";
  }
}

void mainEntidades(){
  Programador pessoa = Programador();
  pessoa.nome = "Reginaldo";
  pessoa.cpf = "111.222.333-44";
  pessoa.nascimento = DateTime(1990, 05, 07);
  pessoa.idade = 31;
  pessoa.sexo = Sexo.Masculino;
  pessoa.salario = 5000.0;

  print(pessoa.toString());
}