import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseBackupRestore {
  static final FirebaseBackupRestore _singleton =
      FirebaseBackupRestore._internal();

  factory FirebaseBackupRestore() {
    return _singleton;
  }

  FirebaseBackupRestore._internal();

  List<String> collections = [];

  //to backing up all given collections
  Future<BackUpResult> backupAll() async {
    BackUpResult backUpResult = BackUpResult();
    if (collections.isEmpty) {
      backUpResult.hasError = true;
      backUpResult.message = "Collections list empty!";
      return backUpResult;
    }
    backUpResult.collection = collections.toString();
    int done = 0;
    for (var collection in collections) {
      backup(collectionId: collection);
      done++;
    }
    if (done != collections.length) {
      backUpResult.hasError = true;
      backUpResult.message = "All collections not backup!";
      return backUpResult;
    }

    backUpResult.hasError = false;
    backUpResult.message = "$done collections successfully backup!";

    return backUpResult;
  }

  //to restoring all given collections
  Future<RestoreResult> restoreAll() async {
    RestoreResult restoreResult = RestoreResult();
    if (collections.isEmpty) {
      restoreResult.hasError = true;
      restoreResult.message = "Collections list empty!";
      return restoreResult;
    }
    restoreResult.collection = collections.toString();
    int done = 0;
    for (var collection in collections) {
      restore(collectionId: collection);
      done++;
    }
    if (done != collections.length) {
      restoreResult.hasError = true;
      restoreResult.message = "All collections not restored!";
      return restoreResult;
    }

    restoreResult.hasError = false;
    restoreResult.message = "$done collections successfully restored!";

    return restoreResult;
  }

  //to backup specific collection
  Future<BackUpResult> backup({required String collectionId}) async {
    /*
    backup json file automatically save on the disk.
    and return the file object and content.
    */
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionId);

    List<String> objList = [];

    await collectionReference.get().then((snapshot) {
      snapshot.docs.forEach((data_) {
        objList.add(json.encode(data_.data()));
      });
    });
    BackUpResult backUpResult = BackUpResult();
    backUpResult.collection = collectionId;

    if (objList.isEmpty) {
      backUpResult.hasError = true;
      backUpResult.message = "object list is empty!";
      return backUpResult;
    }

    backUpResult.hasError = false;
    backUpResult.content = objList.toString();

    var file = await _localFile(collectionId);
    file.writeAsString(backUpResult.content);
    backUpResult.file = file;
    backUpResult.message = "Backup success!";
    return backUpResult;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String name) async {
    final path = await _localPath;
    return File('$path/$name.json');
  }

  //to restore specific collection
  Future<RestoreResult> restore(
      {required String collectionId, String? content}) async {
    /*
    if content is not provided plugin try to find specific backup file.
    if there is no matching backup file, this return an error.
    */

    RestoreResult restoreResult = RestoreResult();
    restoreResult.collection = collectionId;
    if (content == null) {
      var file = await _localFile(collectionId);
      if (await file.exists()) {
        print("file found");
        restoreResult.source = "FILE";
        content = file.readAsStringSync();
      } else {
        print("file not found");
        restoreResult.hasError = true;
        restoreResult.message =
            "Backup file can't find. Set the content attribute.";
        return restoreResult;
      }
    } else {
      print("content has");
      restoreResult.source = "ATTRIBUTE";
    }

    var jsonList = jsonDecode(content) as List;

    if (jsonList.isEmpty) {
      restoreResult.hasError = true;
      restoreResult.message = "empty content found!";
      return restoreResult;
    }
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionId);

    int done = 0;

    for (var obj in jsonList) {
      if (obj['id'] != null) {
        collectionReference.doc(obj['id']).set(obj);
      } else {
        collectionReference.add(obj);
      }
      done++;
    }

    if (done != jsonList.length) {
      restoreResult.hasError = true;
      restoreResult.message = "all objects not restored correctly!";
      return restoreResult;
    }
    restoreResult.hasError = false;
    restoreResult.message = "$done objects successfully restored!";
    return restoreResult;
  }
}

class BackUpResult {
  String? collection;
  late String content;
  File? file;
  bool? hasError;
  String? message;
}

class RestoreResult {
  String? collection;
  String? message;
  String? source;
  bool? hasError;
}
