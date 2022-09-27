import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/repository/repository.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<Widget>>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: snapshot.data!,
              );
            }
            return const SizedBox.shrink();
          }),
    );
  }
}

Future<List<Widget>> getUser() async {
  List<Widget> listOfData = [];
  final currentUserId = repository.firebaseAuth.currentUser!.uid;
  DocumentSnapshot snapShot = await repository.firestore.collection('users').doc(currentUserId).get();
  (snapShot.data() as Map<String, dynamic>).forEach((key, value) {
    listOfData.add(Text(value));
    listOfData.add(const SizedBox(height: 20));
  });
  return listOfData;
}
