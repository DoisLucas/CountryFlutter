class Country {
  int id;
  String nome;
  String capital;
  int area;
  int populacao;
  String governo;
  String lema;
  String hino;
  String linguas;
  String moeda;
  String vizinhos;
  String fMaritimas;
  String bandeiraUrl;

  Country(
      {this.id,
        this.nome,
        this.capital,
        this.area,
        this.populacao,
        this.governo,
        this.lema,
        this.hino,
        this.linguas,
        this.moeda,
        this.vizinhos,
        this.fMaritimas,
        this.bandeiraUrl});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    capital = json['capital'];
    area = json['area'];
    populacao = json['populacao'];
    governo = json['governo'];
    lema = json['lema'];
    hino = json['hino'];
    linguas = json['linguas'];
    moeda = json['moeda'];
    vizinhos = json['vizinhos'];
    fMaritimas = json['f_maritimas'];
    bandeiraUrl = json['bandeira_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['capital'] = this.capital;
    data['area'] = this.area;
    data['populacao'] = this.populacao;
    data['governo'] = this.governo;
    data['lema'] = this.lema;
    data['hino'] = this.hino;
    data['linguas'] = this.linguas;
    data['moeda'] = this.moeda;
    data['vizinhos'] = this.vizinhos;
    data['f_maritimas'] = this.fMaritimas;
    data['bandeira_url'] = this.bandeiraUrl;
    return data;
  }
}