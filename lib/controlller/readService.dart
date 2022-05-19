import 'package:cloud_firestore/cloud_firestore.dart';

class ReadService{
  static FirebaseFirestore db = FirebaseFirestore.instance;



  static Stream<QuerySnapshot>? readAuditors(String email){
    try {
      final result = db.collection("Auditor").where(
          "email", isEqualTo: email).snapshots();
      return result;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }
  static Future<String> getIdByEventNameAndEmail(String ?email) async {
    try {
      var data;
      print("check");
      final result = db.collection("Auditor").where("email",isEqualTo: email);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.id; // <-- Document ID
      }
print(data);

      return data;
    }
    on FirebaseException catch (e) {
      return "1";
    }
  }

  static Future<String> getOrgIdByEmail(String ?email) async {
    try {
      var data;
      print("check");
      final result = db.collection("Organization").where("email",isEqualTo: email);
      var querySnapshots = await result.get();
      for (var snapshot in querySnapshots.docs) {
        data = snapshot.id; // <-- Document ID
      }
      print(data);

      return data;
    }
    on FirebaseException catch (e) {
      return "1";
    }
  }


  static Future readOrgProfile(String id) async {
    try {
      final result = db.collection("Organization").doc(id);
      var query=await result.get();

      var data =query.data();

      print(data!["name"]);

      return data;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }

  static Future readProfile(String id) async {
    try {
      final result = db.collection("Auditor").doc(id);
      var query=await result.get();

      var data =query.data();

      print(data!["name"]);

      return data;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }

  static Stream<QuerySnapshot>? readAllProjects(){
    try {
      final result = db.collection("Project").snapshots();
      return result;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }

  static Stream<QuerySnapshot>? readAllAuditors(){
    try {
      final result = db.collection("Auditor").snapshots();
      return result;
    }
    on FirebaseException catch (e) {
      return null;
    }
  }
}