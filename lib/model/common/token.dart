class Token {
  String refresh;
  String access;

  Token({
    required this.refresh,
    required this.access,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    refresh: json["refresh"] ?? "",
    access: json["access"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "refresh": refresh,
    "access": access,
  };
}