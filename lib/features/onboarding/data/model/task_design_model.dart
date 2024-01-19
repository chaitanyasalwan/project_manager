// ignore_for_file: public_member_api_docs, sort_constructors_first
class TicketTemplate {
  final String name;
  final String assignedTo;
  final String state;
  final String priority;
  final int estimatedDays;
  final int ticketNumber;
  final String iteration;

  TicketTemplate({
    required this.name,
    required this.assignedTo,
    required this.state,
    required this.priority,
    required this.estimatedDays,
    required this.ticketNumber,
    required this.iteration,
  });
}
