import 'package:flutter_application_1/feature/cubit/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/utils/machine.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState(favorites: []));

  void toggleFavorite(Machine machine) {
    final List<Machine> updatedFavorites = List.from(state.favorites);
    
    if (updatedFavorites.contains(machine)) {
      updatedFavorites.remove(machine);
    } else {
      updatedFavorites.add(machine);
    }
    
    emit(FavoritesState(favorites: updatedFavorites));
  }

  bool isFavorite(Machine machine) {
    return state.favorites.contains(machine);
  }
}