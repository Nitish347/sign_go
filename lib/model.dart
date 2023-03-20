class Model {
  String? text;
  String? url;

  Model({this.url, this.text});

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        text: json["text"],
        url: json["url"],
      );
}
