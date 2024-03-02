class Address {
  String? firstName;
  String? sha256FirstName;
  String? lastName;
  String? sha256LastName;
  String? street;
  String? city;
  String? region;
  String? postalCode;
  String? country;

  Address({
    this.firstName,
    this.sha256FirstName,
    this.lastName,
    this.sha256LastName,
    this.street,
    this.city,
    this.region,
    this.postalCode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        firstName: json['first_name'],
        sha256FirstName: json['sha256_first_name'],
        lastName: json['last_name'],
        sha256LastName: json['sha256_last_name'],
        street: json['street'],
        city: json['city'],
        region: json['region'],
        postalCode: json['postal_code'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'sha256_first_name': sha256FirstName,
        'last_name': lastName,
        'sha256_last_name': sha256LastName,
        'street': street,
        'city': city,
        'region': region,
        'postal_code': postalCode,
        'country': country,
      };
}
