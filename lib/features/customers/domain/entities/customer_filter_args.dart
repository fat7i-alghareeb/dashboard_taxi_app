/// Navigation argument used to open a screen (Records / Incidents) pre-filtered
/// to a single customer. Passed via GoRouter `extra`.
class CustomerFilterArgs {
  const CustomerFilterArgs({required this.passengerId, this.name});

  final String passengerId;
  final String? name;
}
