import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeService = HomeServicesImpl();

  Future<void> getHomeContent() async {
    emit(HomeLoading());
    try {
      final newProducts = await homeService.getNewProducts();
      final salesProducts = await homeService.getSalesProducts();
      emit(HomeSuccess(
        salesProducts: salesProducts,
        newProducts: newProducts,
      ));
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }
}
