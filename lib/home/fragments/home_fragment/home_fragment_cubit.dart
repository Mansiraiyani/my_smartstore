import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_smartstore/home/fragments/home_fragment/home_fragment_repository.dart';
import 'package:my_smartstore/home/fragments/home_fragment/home_fragment_state.dart';
import 'package:my_smartstore/models/category_model.dart';

class HomeFragmentCubit extends Cubit<HomeFragmentState> {
  HomeFragmentCubit() : super(HomeFragmentInitial());
  HomeFragmentRepository _repository = HomeFragmentRepository();

  void loadCategories() {
    emit(CategoriesLoading());
    _repository.categories().then((response) {
      emit(CategoriesLoaded(List.from(response.data.map((json)=>CategoryModel.fromJson(json)))));
    }).catchError((value) {
      DioException error = value;
      if (error.response != null) {
        try {
          emit(HomeFragmentFailed(error.response!.data));
        } catch (e) {
          emit(HomeFragmentFailed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioExceptionType) {
          emit(HomeFragmentFailed("please check your internet connection"));
        } else {
          emit(HomeFragmentFailed(error.message!)); //error
        }
      }
    });
  }
}
