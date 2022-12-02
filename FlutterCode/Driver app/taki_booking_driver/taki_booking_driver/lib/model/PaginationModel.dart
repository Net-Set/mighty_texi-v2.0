class PaginationModel {
  int? currentPage;
  var perPage;
  int? totalPages;
  int? totalItems;

  PaginationModel({this.currentPage, this.perPage, this.totalPages, this.totalItems});

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['currentPage'],
      perPage: json['per_page'],
      totalPages: json['totalPages'],
      totalItems: json['total_items'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['totalPages'] = this.totalPages;
    data['total_items'] = this.totalItems;
    return data;
  }
}
