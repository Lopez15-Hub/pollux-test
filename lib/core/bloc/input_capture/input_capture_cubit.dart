import 'package:bloc/bloc.dart';

class InputCaptureCubit extends Cubit<Map<String, dynamic>> {
  InputCaptureCubit() : super({});

  record(String key, String value) {
    emit({...state, key: value});
  }
}
