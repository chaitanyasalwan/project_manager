import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TestUi extends StatefulWidget {
  const TestUi({super.key});

  @override
  State<TestUi> createState() => _TestUiState();
}

class _TestUiState extends State<TestUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Container(
          color: Colors.white,
          constraints: BoxConstraints(maxHeight: 60.h, maxWidth: 60.w),
          child: Padding(
            padding: EdgeInsets.all(1.5.h),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(width: 0.2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.note,
                              size: 3.h,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'Ticket 56',
                            style: TextStyle(fontSize: 2.2.sp),
                          )
                        ]),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 1.h),
                              child: Text('56',
                                  style: TextStyle(fontSize: 3.5.sp)),
                            ),
                            Text('PipeLine Fixing Issues',
                                style: TextStyle(fontSize: 3.5.sp))
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Color.fromARGB(255, 208, 230, 247)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(Icons.person_2_outlined,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Text('Chaitanya Salwan',
                                    style: TextStyle(fontSize: 2.5.sp))),
                            Expanded(
                                child: Text('Assigned By',
                                    style: TextStyle(fontSize: 2.5.sp))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.blue)),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: EdgeInsets.all(.5.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 1.h),
                                              child: Icon(Icons.save),
                                            ),
                                            Text("Save",
                                                style:
                                                    TextStyle(fontSize: 2.sp))
                                          ],
                                        ),
                                      )),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red)),
                                    onPressed: () {},
                                    child: Padding(
                                      padding: EdgeInsets.all(.5.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 1.h),
                                            child: Icon(Icons.close),
                                          ),
                                          Text("Delete",
                                              style: TextStyle(fontSize: 2.sp))
                                        ],
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding:  EdgeInsets.all(1.h),
                      child: Column(children: [
                                        Row(
                      children: [
                        Expanded(
                          child: Row(
                            
                            children: [
                              Text("State"),
                              SizedBox(width: 3.w,),
                              Row(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(right: 0.5.h),
                                    child: Container(
                                      height: 1.h,
                                      width: 1.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(5)),
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Text('New')
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(children: [ 
                             Text("Iteration"),
                               SizedBox(
                                width: 3.w,
                              ),
                             Text('Sprint 1')
                          ],),
                        ),
                        Expanded(child: SizedBox())
                      ],
                                        )
                                      ]),
                    )),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [],
                    ))
              ],
            ),
          ),
        )));
  }
}
