import 'package:sample_to_do_app_ui/database/dao/sub_task_dao.dart';
import 'package:sample_to_do_app_ui/models/sub_task_model.dart';

class SubTaskRepository {
  final SubTaskDao _subTaskDao = SubTaskDao();

  Future<void> updateSubTask(SubTaskModel subTask) async {
    await _subTaskDao.updateSubTask(subTask);
  }

  Future<void> deleteSubTask(int subTaskId) async {
    await _subTaskDao.deleteSubTask(subTaskId);
  }
}
