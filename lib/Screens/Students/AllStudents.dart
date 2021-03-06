import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduvelopeV2/Screens/Students/localData.dart';
import 'package:flutter/material.dart';

import 'package:eduvelopeV2/Screens/Students/StudentListCar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'StudentListCar.dart';
import 'StudentListCar.dart';

class AllStudents extends StatefulWidget {
  final String id;
  final String name;
  final int standard;
  AllStudents({this.name, this.standard,this.id});
  @override
  _AllStudentsState createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  @override
  Widget build(BuildContext context) {
    print(widget.name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        builder: (ctx, stream) {
          if (stream.data != null) {
            return Column(
              children: List.generate(
                stream.data.documents.length,
                (index) {
                  if (stream.data.documents[index]['classID'] == widget.id) {
                    return StudentListCard(
                      uid: stream.data.documents[index]['uniqueID'],
                      id: stream.data.documents[index]['studentId'],
                      name: stream.data.documents[index]['studentName'],
                      standard: stream.data.documents[index]['standard'],
                      classuid: stream.data.documents[index]['classID'],
                    );
                  } else {
                    return null;
                  }
                },
              ).where((element) => element != null).toList(),
            );
          } else {
            return Container();
          }

          // if (stream.data != null) {
          //   return ListView.builder(
          //     itemBuilder: (ctx, index) {
          //       if (currentClassStudents
          //           .contains(stream.data.documents[index]['uniqueID'])) {
          //         return StudentListCard(
          //           id: stream.data.documents[index]['studentId'],
          //           name: stream.data.documents[index]['studentName'],
          //           standard: stream.data.documents[index]['standard'],
          //         );
          //       } else {
          //         return SizedBox(
          //           width: 0,
          //           height: 0,
          //         );
          //       }
          //     },
          //     itemCount: stream.data.documents.length,
          //   );
          // } else {
          //   return Text('HARSH');
          // }
        },
        stream: Firestore.instance.collection('Students').snapshots(),
      ),
    );
  }
}
