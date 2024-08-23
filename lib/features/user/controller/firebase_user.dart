import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createUserDocument() async {
  // Get the current user's UID
  User? user = FirebaseAuth.instance.currentUser;
  print(user?.uid);
  if (user != null) {
    String uid = user.uid;




    // Reference to Firestore collection
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(uid);
    print(userDoc);

    // Data to store
    Map<String, dynamic> userData = {
      'name': user.displayName,
      'phone_number' : user.phoneNumber,
      'new_user' : 1,
    };

    // Create the document with the UID as the ID
    await userDoc.set(userData);
  }
}
