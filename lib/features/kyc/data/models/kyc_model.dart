class KycModel {
  const KycModel({required this.id});

  final String id;

  factory KycModel.fromJson(Map<String, dynamic> json) {
    return KycModel(id: json["id"]);
  }
}
