import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_blog/core/domain/entities/user_entity.dart';
import '../repository/repository.dart';

class CreateUserUseCase {
  createUser(UserData userData) async {
    UserCredential userCredential = await repository.firebaseAuth
        .createUserWithEmailAndPassword(email: userData.email, password: userData.password);
    repository.firestore.collection('users').doc(userCredential.user!.uid).set(userData.toJson());
  }
}
