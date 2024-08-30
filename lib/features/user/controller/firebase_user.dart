import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUserDocument() async {
  User? user = FirebaseAuth.instance.currentUser;
  print(user?.uid);
  if (user != null) {
    String uid = user.uid;




    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(uid);
    print(userDoc);

    Map<String, dynamic> userData = {
      'name': user.displayName,
      'phone_number' : user.phoneNumber,
      'new_user' : 1,
    };

    await userDoc.set(userData);
  }
}
