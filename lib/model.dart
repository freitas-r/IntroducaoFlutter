
enum Sexo {Masculino, Feminino}

Sexo? strToSexo(String? str){
  if(str == null){
    return null;
  }
  switch(str.toUpperCase()){
    case 'MASCULINO':
    case 'M':
      return Sexo.Masculino;
    case 'FEMININO':
    case 'F':
      return Sexo.Feminino;
  }
}


class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  Sexo? sexo;

  Pessoa(this.nome, this.cpf, this.nascimento, this.sexo);

  Pessoa.fromMap(Map<String, String> map){
    nome = map['nome'];
    cpf = map['cpf'];
    nascimento = DateTime.tryParse(map['nascimento'] ?? '2000-01-01');
    sexo = strToSexo(map['sexo']);
  }

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

  Programador(
      String? nome, String? cpf, DateTime? nascimento, Sexo? sexo, this.salario)
  : super(nome, cpf, nascimento, sexo);

  Programador.fromMap(Map<String, String> map) : super.fromMap(map){
    salario = double.tryParse(map['salario'] ?? '0.0');
  }


  @override
  String toString(){
    return "nome=$nome, cpf=$cpf, nascimento=$nascimento, idade=${getIdade()}, sexo=$sexo, salário=$salario";
  }
}

void mainEntidades(){
  final map = {
    'nome': 'Fernando',
    'nascimento': '1990-05-07',
    'sexo': 'M',
    'salario': '10000.0'
  };

  List<String> nomes = ['Carlos', 'Alberto', 'João'];

  for(int i = 0; i < nomes.length; i++){
    if(nomes[i].toUpperCase().startsWith('J')){
      break;
    }
    print("$i - ${nomes[i]}");

  }

  // Pessoa pessoa = Programador.fromMap(map);
  // pessoa.nome = "Reginaldo";
  // pessoa.cpf = "111.222.333-44";
  // pessoa.nascimento = DateTime(1990, 05, 07);
  // pessoa.idade = 31;
  // pessoa.sexo = Sexo.Masculino;
  // pessoa.salario = isBoss ? 20000.0 : 5000.0;

  // print(pessoa.toString());
}