import 'package:cloud_firestore/cloud_firestore.dart';

class WriteService {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<String?> addUser({required String email , required String name, required String phoneno, required String experience,required String cnic}) async {
    final user = <String, dynamic>{"email": email,"name":name, "phone_number":phoneno, "experience": experience, "cnic":cnic,  "number_of_projects": '0', "total_earning": '0', "rating": '0'};
    try {
      await db.collection("Auditor").add(user);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> addOrganizer({required String email, required String name, required String phoneno, required String businessdetail,required String ntn,required String address}) async {
    final org = <String, dynamic>{"email": email,"name":name, "phone_number":phoneno, "address": address, "ntn":ntn,  "businessdetail":businessdetail};
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

  static Future<String?> buyTicket(
      {required String username,
      required String trasactionId,
      required String userBank,
      required String userEmail,
      required String Eventprice,
      required String eventName,
      required String eventDescription,
      required String eventDate}) async {
    final ticket = <String, dynamic>{
      "userName": username,
      "eventDescription": eventDescription,
      "date": eventDate,
      "userEmail": userEmail,
      "price": Eventprice,
      "transactionID": trasactionId,
      "eventName": eventName,
      "vStatus": "false",
      "bStatus": "false"
    };
    try {
      await db.collection("tickets").add(ticket);
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> approvePayment(String id) async {
    try {
      db.collection("tickets").doc(id).update({"bStatus": "true"});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
static  Future<String?> updateStatus(String id, String value)async{
    try {
      db.collection("Project").doc(id).update({"stage": value});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
  static Future<String?> approveTicket(String id) async {
    try {
      db.collection("tickets").doc(id).update({"vStatus": "true"});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> hireAuditor(String id, String auditor_id) async {
    try {
      db.collection("Project").doc(id).update({"auditorID": auditor_id});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  static Future<String?> declinePayment(String id) async {
    try {
      db.collection("tickets").doc(id).update({"bStatus": "false"});
      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
