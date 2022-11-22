import 'package:get/get.dart';
import 'package:todo_timer/app/database/db.dart';

import '../../../models/notes_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxList<Notes> notesList = RxList.empty(growable: true);
  final count = 0.obs;

  getAllNotes() {
    DBProvider.db.getDataFromNotes().then((value) {
      notesList.value = value;
    });
  }

 Future deleteNote(int id) {
   return DBProvider.db.removeNote(id);

  }


  @override
  void onInit() {
    super.onInit();
    getAllNotes();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
