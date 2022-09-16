
import 'package:cloud_firestore/cloud_firestore.dart';

class ProofPicsModel {
  Timestamp picTime;
  String picURL;
  String? picNotes;

  
  ProofPicsModel({
    required this.picTime,
    required this.picURL,
    required this.picNotes,
  });

  Map<String, dynamic> toMap() {
    return {
      fofppm.picTime:picTime,
       fofppm.picURL:picURL,
        fofppm.picNotes:picNotes,
      
    };
  }

  factory ProofPicsModel.fromMap(Map docMap) {
    return ProofPicsModel(
      picTime: docMap[fofppm.picTime],
      picURL: docMap[fofppm.picURL],
      picNotes: docMap[fofppm.picNotes],
    );
  }
}

FinalObjectsForProofPicsModel fofppm = FinalObjectsForProofPicsModel();

class FinalObjectsForProofPicsModel {
  
  final String picTime = "picTime";
  final String picURL = "picURL";
  final String picNotes = "picNotes";
}
