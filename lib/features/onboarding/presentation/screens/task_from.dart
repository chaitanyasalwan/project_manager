import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_manager/features/onboarding/data/model/ticket_response_model.dart';

class TicketDialogForm extends StatefulWidget {
  final Function callback;
  TicketDialogForm(this.callback);
  @override
  _TicketDialogFormState createState() => _TicketDialogFormState();
}

class _TicketDialogFormState extends State<TicketDialogForm> {
  final _formKey = GlobalKey<FormState>();
  String _ticketName = '';
  String _description = '';
  int _estimatedDays = 0;
  String _selectedIteration = 'Iteration 1';
  String _selectedState = 'New';
  int _selectedPriority = 1; // Default to Low priority (1)

  List<String> iterations = ['Iteration 1', 'Iteration 2', 'Iteration 3'];
  List<String> states = [
    'New',
    'In Progress',
    'Bug',
    'Review',
    'Backlog',
    'Resolved',
  ];
  List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical'
  ]; // Added Critical option

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Ticket'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Ticket Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the ticket name';
                  }
                  return null;
                },
                onSaved: (value) => _ticketName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estimated Days'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the estimated days';
                  }
                  return null;
                },
                onSaved: (value) => _estimatedDays = int.parse(value!),
              ),
              DropdownButtonFormField<String>(
                value: _selectedIteration,
                decoration: InputDecoration(labelText: 'Iteration'),
                items: iterations
                    .map((iteration) => DropdownMenuItem<String>(
                          value: iteration,
                          child: Text(iteration),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedIteration = value!),
              ),
              DropdownButtonFormField(
                value: _selectedState,
                decoration: InputDecoration(labelText: 'State'),
                items: states
                    .map((state) => DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        ))
                    .toList(),
                onChanged: (value) {
                  _selectedState = value!.toString();
                },
              ),
              DropdownButtonFormField(
                value: _selectedPriority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: priorities
                    .map<DropdownMenuItem>(
                        (priority) => DropdownMenuItem<int>(
                              value: getPriorityValue(priority),
                              child: Text(priority),
                            ))
                    .toList(),
                onChanged: (value) {
                  _selectedPriority = value!;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
                           TicketResponseModel dummyTicket = TicketResponseModel(
                assignDetails: AssignDetails(
                  assignedBy: AssignedBy(
                    name: 'Smith',
                    time: Timestamp.now(),
                    uid: 'user123',
                    url: 'https://example.com/avatar.jpg',
                  ),
                  assignedTo: AssignedBy(
                    name: 'Jane Smith',
                    time: Timestamp.now(),
                    uid: 'user456',
                    url: 'https://example.com/avatar2.jpg',
                  ),
                ),
                basicDetails: BasicDetails(
                  description: _description,
                  estimatedDays: _estimatedDays,
                  isActive: true,
                  iteration: _selectedIteration,
                  priority: _selectedPriority,
                  state: _selectedState,
                  timeStamp: Timestamp.now(),
                  title: _ticketName,
                ),
              );
              widget.callback(dummyTicket,'New');
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }

  int getPriorityValue(String priority) {
    switch (priority) {
      case 'Low':
        return 1;
      case 'Medium':
        return 2;
      case 'High':
        return 3;
      case 'Critical':
        return 4;
      default:
        return 1;
    }
  }
}
