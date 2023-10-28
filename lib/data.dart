class data {
  String tittle;
  String content;
  data({required this.tittle, required this.content});
  factory data.fromJson(Map<String, dynamic> json) => data(
        tittle: json["tittle"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "tittle": tittle,
        "content": content,
    };
}
