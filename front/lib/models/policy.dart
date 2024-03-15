class Policy {
  final int id;
  final String issueDate;
  final String insuredName;
  final String vehicleYear;
  final String vehicleBrand;

  Policy({
    required this.id,
    required this.issueDate,
    required this.insuredName,
    required this.vehicleYear,
    required this.vehicleBrand,
  });

  // factory that creates policy from result of graphql query

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      id: int.parse(json['policyId']),
      issueDate: json['issueDate'],
      insuredName: json['insuredName'],
      vehicleYear: json['vehicleYear'],
      vehicleBrand: json['vehicleBrand'],
    );
  }
}
