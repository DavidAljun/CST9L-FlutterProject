import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addUserDataToFirestore(
    User user, String firstName, String lastName) async {
  // Access the current user's UID
  String userId = user.uid;

  // Reference the 'users' collection and the user's document using the UID
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  DocumentReference userDocument = usersCollection.doc(userId);

  // Add or update user-related information in the document
  await userDocument.set({
    'firstName': firstName,
    'lastName': lastName,
    'email': user.email,
    // Add other user-related fields as needed
  });
}
