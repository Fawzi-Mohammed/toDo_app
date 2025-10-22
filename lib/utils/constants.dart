import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/utils/app_str.dart';

const String lottieURL = 'assets/lottie/1.json';
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message:
        'There is no Task for delete!\n Try adding some and then try to delete it',
    buttonText: 'Okay',
    onTapDismiss: () => Navigator.pop(context),
    panaraDialogType: PanaraDialogType.normal,
  );
}

dynamic deleateAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    message:
        'Do You really Want to delete all tasks? You will no be able to undo this action!',
    confirmButtonText: 'Yes',
    cancelButtonText: 'No',
    onTapConfirm: () {
      context.read<TaskCubit>().confirmDeleteAllTasks();

      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
