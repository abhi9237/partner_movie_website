class Demographics {
  int? india;
  int? others;
  int? uncategorised;

  Demographics({this.india, this.others, this.uncategorised});

  Demographics.fromJson(Map<String, dynamic> json) {
    india = json['india'];
    others = json['others'];
    uncategorised = json['uncategorised'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['india'] = this.india;
    data['others'] = this.others;
    data['uncategorised'] = this.uncategorised;
    return data;
  }
}