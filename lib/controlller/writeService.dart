import 'package:cloud_firestore/cloud_firestore.dart';

class WriteService {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static Future<String?> deleteProject(String id) async {
    try {
      db.collection("Project").doc(id).delete();
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> addUser(
      {required String email,
      required String name,
      required String phoneno,
      required String experience,
      required String cnic}) async {
    final user = <String, dynamic>{
      "email": email,
      "name": name,
      "phone_number": phoneno,
      "experience": experience,
      "cnic": cnic,
      "number_of_projects": 0,
      "total_earning": "0",
      "rating": 0,
      "total_reviews": 0,
      "availability": true
    };
    try {
      await db.collection("Auditor").add(user);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> addOrganizer(
      {required String email,
      required String name,
      required String phoneno,
      required String businessdetail,
      required String ntn,
      required String address}) async {
    final org = <String, dynamic>{
      "email": email,
      "name": name,
      "phone_number": phoneno,
      "address": address,
      "ntn": ntn,
      "businessdetail": businessdetail
    };
    try {
      await db.collection("Organization").add(org);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> createProject(
      {required String email,
      required String title,
      required String details,
      required String date,
      required String budget,
      required String orgID,
      required String auditorID}) async {
    final event = <String, dynamic>{
      "title": title,
      "details": details,
      "date": date,
      "organizerID": orgID,
      "budget": budget,
      "auditorID": auditorID,
    };
    try {
      await db.collection("Project").add(event);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> writeReview(String reviewNote, double reviewRating,
      String auditorID, String organizerID) async {
    try {
      await db.collection("reviews").add({
        "reviewNote": reviewNote,
        "reviewRating": reviewRating,
        "auditorID": auditorID,
        "organizerID": organizerID
      });
      var advisor = await db.collection("Auditor").doc(auditorID).get();
      double rating = double.parse(advisor["rating"].toString());
      double totalReviews = double.parse(advisor["total_reviews"].toString());
      double sum = rating * totalReviews;
      sum += reviewRating;
      totalReviews++;
      rating = sum / totalReviews;

      await db
          .collection("Auditor")
          .doc(auditorID)
          .update({"total_reviews": totalReviews, "rating": rating});
    } on FirebaseException catch (e) {
      return e.message;
    }
  }


  static Future<String?> updateStatus(String id, String value) async {
    try {
      db.collection("Project").doc(id).update({"stage": value});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }


  static Future<String?> hireAuditor(String id, String auditorId) async {
    try {
      db.collection("Project").doc(id).update({"auditorID": auditorId});
      db
          .collection("Auditor")
          .doc(auditorId)
          .update({"number_of_projects": "1"});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }


  static Future<String?> updateAvailability(String id, bool value) async {
    try {
      db.collection("Auditor").doc(id).update({"availability": value});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
