import 'package:bloc/bloc.dart';

class PageManagerCubit extends Cubit<int> {
  PageManagerCubit() : super(0);

  changePage(int currentPage) => emit(currentPage);
}
