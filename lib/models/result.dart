class Result_ {
  String Title;
  String Detail;

  Result_({required this.Title, required this.Detail});

  factory Result_.fromJson(Map<String, dynamic> json) {
    return Result_(
      Title: json['Title'],
      Detail: json['Detail'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'Title': Title,
        'Detail': Detail,
      };

}