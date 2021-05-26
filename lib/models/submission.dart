class Submission {
  String Service;
  String Payload;
  int ValueCode;

  Submission({required this.Service, required this.Payload, required this.ValueCode});


  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      Service: json['Service'],
      Payload: json['Payload'],
      ValueCode: json['ValueCode'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'Service': Service,
        'Payload': Payload,
        'ValueCode': ValueCode
      };
}