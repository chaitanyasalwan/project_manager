import 'package:flutter/material.dart';
import 'package:project_manager/features/onboarding/data/model/task_design_model.dart';

class TaskComponent extends StatefulWidget {
  const TaskComponent({super.key, required this.ticketTemplate});
  final TicketTemplate ticketTemplate;
  @override
  State<TaskComponent> createState() => _TaskComponentState();
}

class _TaskComponentState extends State<TaskComponent> {
  @override
  Widget build(BuildContext context) {
    return Card(
  surfaceTintColor: Colors.transparent,
  color: Color(0xffffffff),
        child: Container(
      width: double.infinity,
   
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child:
                         (widget.ticketTemplate.state == "Bug")?Icon(Icons.bug_report_outlined,color: Colors.red,): (widget.ticketTemplate.state == "Resolved")?Icon(
                              Icons.task,
                              color: Colors.green,
                            ) : (widget.ticketTemplate.state == "Review")?Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.blue,
                            ) : (widget.ticketTemplate.state == "Backlog")?Icon(
                              Icons.access_time_outlined,
                              color: Colors.blueGrey,
                            ) : Icon(
                                          Icons.task,
                                          color: Colors.blue,
                                        ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(widget.ticketTemplate.ticketNumber.toString()),
                ),
                Expanded(child: Text(widget.ticketTemplate.name))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: 
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Color(0xffefebf9)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.person_2_outlined, color: Color(0xff8768d1)),
                          ),
                        ),
                      ),
                      Expanded(child: Text(widget.ticketTemplate.assignedTo)),
                       Text(widget.ticketTemplate.estimatedDays.toString())
                    ],
                  ),
                 
              
            ),
            Column(
              children: [
                Row(
                      children: [
                        Expanded(child: Text("Iteration")),
                        Expanded(child: Text(widget.ticketTemplate.iteration))
                      ],
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 10 ,bottom:10 ),
                  child: Row(
                    
                    children: [
                      Expanded(child: Text("State")),
                    
                      Expanded(child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(height: 8,width: 8,decoration: BoxDecoration(color:(widget.ticketTemplate.state == "New")?Colors.grey: (widget.ticketTemplate.state ==
                                                  "Bug")?Colors.red: (widget.ticketTemplate.state ==
                                                  "Resolved")?Colors.green:Colors.blue,borderRadius:BorderRadius.all(Radius.circular(5)) ),),
                          ),
                          
                          Expanded(child: Text(widget.ticketTemplate.state)),
                        ],
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Text("Priority")),
                    Expanded(child:(widget.ticketTemplate.priority == '1')? Text("Low"):(widget.ticketTemplate.priority == '2')?Text("Medium"):(widget.ticketTemplate.priority == '3')?Text("High"): (widget.ticketTemplate.priority ==
                                            '4')?Text('Critical'):Text('Error'))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
