class AIModel {
  String? asked;
  String response;

  AIModel({this.asked, required this.response});

  AIModel.fromJson(Map<String, dynamic> json)
      : asked = json['asked'],
        response = json['response'] ?? 'No response';

  Map<String, dynamic> toJson() {
    return {
      'asked': asked,
      'response': response,
    };
  }
}
