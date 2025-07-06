import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_jobs_event.dart';
import 'favorite_jobs_state.dart';

class FavoriteJobsBloc extends Bloc<FavoriteJobsEvent, FavoriteJobsState> {
  final SharedPreferences prefs;
  static const _key = 'favorite_jobs';

  FavoriteJobsBloc(this.prefs) : super(FavoriteJobsInitial()) {
    on<LoadFavoriteJobs>(_onLoadFavorites);
    on<ToggleFavoriteJob>(_onToggleFavorite);
    add(LoadFavoriteJobs());
  }

  void _onLoadFavorites(LoadFavoriteJobs event, Emitter<FavoriteJobsState> emit) {
    final ids = prefs.getStringList(_key) ?? [];
    emit(FavoriteJobsLoaded(ids.toSet()));
  }

  void _onToggleFavorite(ToggleFavoriteJob event, Emitter<FavoriteJobsState> emit) {
    final current = (state is FavoriteJobsLoaded) ? (state as FavoriteJobsLoaded).favoriteJobIds : <String>{};
    final updated = Set<String>.from(current);
    if (updated.contains(event.jobId)) {
      updated.remove(event.jobId);
    } else {
      updated.add(event.jobId);
    }
    prefs.setStringList(_key, updated.toList());
    emit(FavoriteJobsLoaded(updated));
  }
}
