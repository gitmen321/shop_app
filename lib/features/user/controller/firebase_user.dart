import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUserDocument() async {
  User? user = FirebaseAuth.instance.currentUser;
  
  if (user != null) {
    String uid = user.uid;




    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(uid);
    

    Map<String, dynamic> userData = {
      'name': user.displayName,
      'phone_number' : user.phoneNumber,
      'new_user' : 1,
    };

    await userDoc.set(userData);
  }
}
