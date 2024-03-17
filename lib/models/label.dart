class Label {
  String nome;
  double probability;

  static const List<Label> labels = [];

  Label({required this.nome, required this.probability});

  factory Label.fromJson(dynamic row){
    return Label(nome: row['nome'] as String, probability: row['nome'] as double);
  }
  
}