import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_manager/features/onboarding/data/model/task_design_model.dart';
import 'package:project_manager/features/onboarding/data/model/ticket_response_model.dart';
import 'package:project_manager/features/onboarding/presentation/screens/task_component.dart';
import 'package:project_manager/features/onboarding/presentation/screens/task_from.dart';
import 'package:project_manager/features/onboarding/presentation/screens/task_view_form.dart';

class TaskBoardPage extends StatefulWidget {
  @override
  _TaskBoardPageState createState() => _TaskBoardPageState();
}

class _TaskBoardPageState extends State<TaskBoardPage> {
  @override
  void initState() {
    super.initState();
  }

  List<TicketResponseModel> newTasks = [];
  List<TicketResponseModel> inProgressTasks = [];
  List<TicketResponseModel> resolvedTasks = [];
  List<TicketResponseModel> backlogTasks = [];
  List<TicketResponseModel> failedTasks = [];
  List<TicketResponseModel> reviewTasks = [];

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return TicketDialogForm(_addTask);

        // return AlertDialog(
        //   title: Text('Add New Task'),
        //   content: TextField(
        //     onChanged: (value) {
        //       newTaskName = value;
        //     },
        //     decoration: InputDecoration(
        //       labelText: 'Task Name',
        //     ),
        //   ),
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         Navigator.pop(context); // Close the dialog
        //       },
        //       child: Text('Cancel'),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         if (newTaskName.isNotEmpty) {

        //           _addTask(dummyTicket, 'New');
        //         }
        //         Navigator.pop(context); // Close the dialog
        //       },
        //       child: Text('Submit'),
        //     ),
        //   ],
        // );
      },
    );
  }

  void _addTask(TicketResponseModel task, String columnTitle) async {
    addNewTask(task);
    setState(() {
      switch (columnTitle) {
        case 'New':
          newTasks.add(task);
          break;
        case 'In Progress':
          inProgressTasks.add(task);
          break;
        case 'Resolved':
          resolvedTasks.add(task);
          break;
        case 'Backlog':
          backlogTasks.add(task);
          break;
        case 'Failed':
          failedTasks.add(task);
          break;
        case 'Review':
          reviewTasks.add(task);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kanban Board'),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              _showAddTaskDialog();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<TicketResponseModel>>(
        stream: readTickets(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Case 2: Data loading has failed
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            // Case 3: Data has successfully loaded and is not empty
            final list = snapshot.data!;
            inProgressTasks = list
                .where((e) => e.basicDetails!.state == 'In Progress')
                .toList();
            newTasks =
                list.where((e) => e.basicDetails!.state == 'New').toList();
            reviewTasks = reviewTasks =
                list.where((e) => e.basicDetails!.state == 'Review').toList();
            failedTasks =
                list.where((e) => e.basicDetails!.state == 'Bug').toList();
            backlogTasks =
                list.where((e) => e.basicDetails!.state == 'Backlog').toList();
            resolvedTasks =
                list.where((e) => e.basicDetails!.state == 'Resolved').toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        6, // You may want to use list.length here or adjust accordingly
                    itemBuilder: (context, index) {
                      return _buildColumn(index, constraints.maxWidth);
                    },
                  );
                },
              ),
            );
          } else {
            // Case 4: Data has successfully loaded, but it's empty
            return SizedBox(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildColumn(int columnIndex, double maxWidth) {
    List<TicketResponseModel> tasks;
    String title;

    switch (columnIndex) {
      case 0:
        title = 'New';
        tasks = newTasks;
        break;
      case 1:
        title = 'In Progress';
        tasks = inProgressTasks;
        break;
      case 2:
        title = 'Bug';
        tasks = failedTasks;
        break;
      case 3:
        title = 'Review';
        tasks = reviewTasks;
        break;
      case 4:
        title = 'Backlog';
        tasks = backlogTasks;
        break;

      case 5:
        title = 'Resolved';
        tasks = resolvedTasks;
        break;

      default:
        throw Exception('Invalid column index');
    }

    return DragTarget<TicketResponseModel>(
      builder: (BuildContext context, List<TicketResponseModel?> candidateData,
          List<dynamic> rejectedData) {
        return Card(
          surfaceTintColor: Colors.transparent,
          color: Colors.white,
          margin: EdgeInsets.all(8),
          child: Container(
            width: maxWidth / 6.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: _buildTaskList(tasks, maxWidth),
                ),
              ],
            ),
          ),
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        _moveTask(data!, title);
      },
    );
  }

  Widget _buildTaskList(List<TicketResponseModel> tasks, double maxWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Draggable<TicketResponseModel>(
              data: tasks[index],
              feedback:
                  _buildTaskItemDrag(tasks[index], isDragging: true, maxWidth),
              child: _buildTaskItem(tasks[index], maxWidth),
              childWhenDragging: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[300]),
                  height: 150,
                  width: maxWidth / 7),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTaskItem(TicketResponseModel task, double maxWidth,
      {bool isDragging = false}) {
    return GestureDetector(
      onTap: () {
           showDialog(
          context: context,
          builder: (context) {
            return TaskViewFormDialog();

            // return AlertDialog(
            //   title: Text('Add New Task'),
            //   content: TextField(
            //     onChanged: (value) {
            //       newTaskName = value;
            //     },
            //     decoration: InputDecoration(
            //       labelText: 'Task Name',
            //     ),
            //   ),
            //   actions: [
            //     TextButton(
            //       onPressed: () {
            //         Navigator.pop(context); // Close the dialog
            //       },
            //       child: Text('Cancel'),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {
            //         if (newTaskName.isNotEmpty) {

            //           _addTask(dummyTicket, 'New');
            //         }
            //         Navigator.pop(context); // Close the dialog
            //       },
            //       child: Text('Submit'),
            //     ),
            //   ],
            // );
          },
        );
      },
      child: TaskComponent(
        ticketTemplate: TicketTemplate(
          iteration: task.basicDetails!.iteration!,
          name: task.basicDetails!.title.toString(),
          assignedTo: task.assignDetails!.assignedTo!.name.toString(),
          state: task.basicDetails!.state.toString(),
          priority: task.basicDetails!.priority.toString(),
          estimatedDays: task.basicDetails!.estimatedDays!,
          ticketNumber: task.basicDetails!.id!,
        ),
      ),
    );
  }

  Widget _buildTaskItemDrag(TicketResponseModel task, double maxWidth,
      {bool isDragging = false}) {
    return Container(
      width: maxWidth / 6.3,
      child: TaskComponent(
        ticketTemplate: TicketTemplate(
          iteration: task.basicDetails!.iteration!,
          name: task.basicDetails!.title.toString(),
          assignedTo: task.assignDetails!.assignedTo!.name.toString(),
          state: task.basicDetails!.state.toString(),
          priority: task.basicDetails!.priority.toString(),
          estimatedDays: task.basicDetails!.estimatedDays!,
          ticketNumber: task.basicDetails!.id!,
        ),
      ),
    );
  }

  void _moveTask(TicketResponseModel task, String destinationColumn) async {
    // Remove the task from its original column
    updateTicketState(
      task.basicDetails!.id!,
      destinationColumn,
    );

    setState(() {
      if (newTasks.contains(task)) {
        newTasks.remove(task);
      } else if (inProgressTasks.contains(task)) {
        inProgressTasks.remove(task);
      } else if (resolvedTasks.contains(task)) {
        resolvedTasks.remove(task);
      } else if (failedTasks.contains(task)) {
        failedTasks.remove(task);
      } else if (reviewTasks.contains(task)) {
        reviewTasks.remove(task);
      } else if (backlogTasks.contains(task)) {
        backlogTasks.remove(task);
      }
    });

    // Add the task to the new column
    setState(() {
      switch (destinationColumn) {
        case 'New':
          newTasks.add(task);
          break;
        case 'In Progress':
          inProgressTasks.add(task);
          break;
        case 'Resolved':
          resolvedTasks.add(task);
          break;

        case 'Bug':
          failedTasks.add(task);
          break;
        case 'Review':
          reviewTasks.add(task);
          break;
        case 'Backlog':
          backlogTasks.add(task);
          break;
      }
    });
  }

  String? _getColumnFromTask(String task) {
    if (newTasks.contains(task)) {
      return 'New';
    } else if (inProgressTasks.contains(task)) {
      return 'In Progress';
    } else if (resolvedTasks.contains(task)) {
      return 'Resolved';
    } else if (failedTasks.contains(task)) {
      return 'Bug';
    } else if (reviewTasks.contains(task)) {
      return 'Review';
    } else if (backlogTasks.contains(task)) {
      return 'Backlog';
    }
    return null;
  }

  Future addNewTask(TicketResponseModel model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('tickets')
        .doc('portfolioproject');

    // Fetch the current list of tickets from Firestore
    DocumentSnapshot documentSnapshot = await documentReference.get();
    model.basicDetails!.id = documentSnapshot.get('totalTickets') + 1;
    final docUser = FirebaseFirestore.instance
        .collection('tickets')
        .doc('portfolioproject');

    final listString = {
      'totalTickets': FieldValue.increment(1),
      'tickets': FieldValue.arrayUnion([model.toJson()])
    };
    await docUser.set(listString, SetOptions(merge: true));
  }

  List<TicketResponseModel> tickets = [];
  Stream<List<TicketResponseModel>> readTickets() {
    return FirebaseFirestore.instance
        .collection('tickets')
        .doc('portfolioproject')
        .snapshots()
        .map((ticket) {
      if (!ticket.exists || ticket.data() == null) {
        return []; // Return an empty list if the document doesn't exist or has no data
      }

      List<dynamic> ticketsData = ticket.data()!['tickets'] as List<dynamic>;

      if (ticketsData == null) {
        return []; // Return an empty list if the 'tickets' field is null
      }

      tickets = ticketsData
          .map((e) => TicketResponseModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return tickets;
    });
  }

  Future<void> updateTicketState(int id, String newState) async {
    // Replace 'portfolioproject' with your actual document ID
    String documentId = 'portfolioproject';

    // Reference to the Firestore document
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('tickets').doc(documentId);

    // Fetch the current list of tickets from Firestore
    DocumentSnapshot documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      // Retrieve the 'tickets' array from the document data
      List<dynamic>? ticketsData = documentSnapshot.get('tickets');

      if (ticketsData != null) {
        // Cast the elements to Map<String, dynamic>
        List<Map<String, dynamic>> typedTicketsData =
            List<Map<String, dynamic>>.from(ticketsData);

        // Find the index of the ticket with the given title
        int index = typedTicketsData.indexWhere(
          (ticketData) => ticketData['basicDetails']['id'] == id,
        );

        if (index != -1) {
          // Update the 'state' property of the ticket
          typedTicketsData[index]['basicDetails']['state'] = newState;

          // Update the Firestore document with the modified 'tickets' array
          await documentReference.update({'tickets': typedTicketsData});
        }
      }
    }
  }
}
