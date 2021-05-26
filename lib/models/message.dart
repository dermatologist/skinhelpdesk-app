import 'package:skinhelpdesk_app/models/result.dart';

class Message {
  String Service;
  List<Result_> Result;
  int ValueCode;

  Message({required this.Service, required this.Result, required this.ValueCode});

  // https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
  factory Message.fromJson(Map<String, dynamic> json) {
    var resultsFromJson = json['Result'];
    // https://github.com/PoojaB26/ParsingJSON-Flutter/blob/master/lib/model/address_model.dart
    List<Result_> results = resultsFromJson.cast<Result_>();
    return new Message(
      Service: json['Service'],
      Result: results,
      ValueCode: json['ValueCode'],
    );
  }

//  Map<String, dynamic> toJson() =>
//      {
//        'Service': Service,
//        'Result': Result,
//        'ValueCode': ValueCode
//      };

}