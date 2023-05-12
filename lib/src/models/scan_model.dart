class ScanModel {
  int? id;
  String? tipo;
  String? valor;

  ScanModel ({
    this.id,
    this.tipo,
    this.valor,
  }){
    if( valor!.contains("http") ){
      tipo = "http";
    } else if (valor!.contains("geo")){
      tipo = "geo";
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
    id: json["id"],
    tipo: json["tipo"],
    valor: json["valor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipo": tipo,
    "valor": valor,
  };
}