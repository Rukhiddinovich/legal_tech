import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/view_status.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();
  @override
  List<Object?> get props => [];
}

class GetArticlesRequested extends ArticleEvent {
  const GetArticlesRequested();
}

class SearchArticlesChanged extends ArticleEvent {
  final String query;
  const SearchArticlesChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class CategoryFilterChanged extends ArticleEvent {
  final String category;
  const CategoryFilterChanged(this.category);
  @override
  List<Object?> get props => [category];
}

class ArticleState extends Equatable {
  final ViewStatus status;
  final List<Article> allArticles;
  final List<Article> filteredArticles;
  final String selectedCategory;
  final String searchQuery;
  final String? error;

  const ArticleState({
    this.status = ViewStatus.initial,
    this.allArticles = const [],
    this.filteredArticles = const [],
    this.selectedCategory = 'Barchasi',
    this.searchQuery = '',
    this.error,
  });

  ArticleState copyWith({
    ViewStatus? status,
    List<Article>? allArticles,
    List<Article>? filteredArticles,
    String? selectedCategory,
    String? searchQuery,
    String? error,
  }) {
    return ArticleState(
      status: status ?? this.status,
      allArticles: allArticles ?? this.allArticles,
      filteredArticles: filteredArticles ?? this.filteredArticles,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allArticles,
        filteredArticles,
        selectedCategory,
        searchQuery,
        error,
      ];
}

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _repository;

  ArticleBloc(this._repository) : super(const ArticleState()) {
    on<GetArticlesRequested>(_onGetArticles);
    on<SearchArticlesChanged>(_onSearchChanged);
    on<CategoryFilterChanged>(_onCategoryChanged);
  }

  Future<void> _onGetArticles(
    GetArticlesRequested event,
    Emitter<ArticleState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _repository.getArticles();
    result.fold(
      (failure) => emit(
        state.copyWith(status: ViewStatus.failure, error: failure.message),
      ),
      (articles) {
        emit(
          state.copyWith(
            status: ViewStatus.success,
            allArticles: articles,
            filteredArticles: articles,
          ),
        );
      },
    );
  }

  void _onSearchChanged(
    SearchArticlesChanged event,
    Emitter<ArticleState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
    _applyFilter(emit);
  }

  void _onCategoryChanged(
    CategoryFilterChanged event,
    Emitter<ArticleState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
    _applyFilter(emit);
  }

  void _applyFilter(Emitter<ArticleState> emit) {
    List<Article> list = state.allArticles;
    
    // Category filter
    if (state.selectedCategory != 'Barchasi') {
      list = list
          .where((a) => a.category.toLowerCase() == state.selectedCategory.toLowerCase())
          .toList();
    }
    
    // Search query
    if (state.searchQuery.isNotEmpty) {
      final q = state.searchQuery.toLowerCase();
      list = list
          .where((a) =>
              a.title.toLowerCase().contains(q) ||
              a.content.toLowerCase().contains(q))
          .toList();
    }
    
    emit(state.copyWith(filteredArticles: list));
  }
}
