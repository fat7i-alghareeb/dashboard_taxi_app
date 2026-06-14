/// Company contact details shown on invoices, editable by admins.
class CompanyContactEntity {
  const CompanyContactEntity({
    required this.email,
    required this.phone,
    required this.website,
  });

  final String email;
  final String phone;
  final String website;
}
