import 'package:sample_to_do_app_ui/database/dao/sub_task_dao.dart';
import 'package:sample_to_do_app_ui/models/sub_task_model.dart';

class SubTaskRepository {
  final SubTaskDao _subTaskDao = SubTaskDao();

  Future<void> addSubTask(SubTaskModel subTask) async {
    await _subTaskDao.insertSubTask(subTask);
  }

  Future<SubTaskModel?> getSubTaskById(int subTaskId) async {
    return await _subTaskDao.getSubTaskById(subTaskId);
  }

  Future<void> updateSubTask(SubTaskModel subTask) async {
    await _subTaskDao.updateSubTask(subTask);
  }

  Future<void> deleteSubTask(int subTaskId) async {
    await _subTaskDao.deleteSubTask(subTaskId);
  }

  Future<List<SubTaskModel>> getSubTasksByTaskId(int taskId) async {
    return await _subTaskDao.getSubTasksByTaskId(taskId);
  }
}
