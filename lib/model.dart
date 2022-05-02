
enum Sexo {Masculino, Feminino}

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  Sexo? sexo;
  double? salario;
  bool? programador;


  @override
  String toString() {
    return "nome=$nome, cpf=$cpf, nascimento=$nascimento, idade=$idade, sexo=$sexo, salário=$salario, programador=$programador";
  }
}



void mainEntidades(){
  Pessoa pessoa = Pessoa();
  pessoa.nome = "Reginaldo";
  pessoa.cpf = "111.222.333-44";
  pessoa.nascimento = DateTime(1990, 05, 07);
  pessoa.idade = 31;
  pessoa.sexo = Sexo.Masculino;
  pessoa.salario = 10000.0;
  pessoa.programador = true;

  print(pessoa.toString());
}