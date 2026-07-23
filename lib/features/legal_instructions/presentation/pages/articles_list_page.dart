import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/view_status.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_route_names.dart';
import '../../../../core/widgets/adolat_loader.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../../../../core/widgets/global_text.dart';
import '../../../../core/widgets/global_text_field.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/article.dart';
import '../bloc/article_bloc.dart';

class ArticlesListPage extends StatelessWidget {
  const ArticlesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleBloc>(
      create: (_) => sl<ArticleBloc>()..add(const GetArticlesRequested()),
      child: const _ArticlesListView(),
    );
  }
}

class _ArticlesListView extends StatelessWidget {
  const _ArticlesListView();

  static const _categories = ['Barchasi', 'Oila huquqi', 'Meros huquqi', 'Mehnat huquqi', 'Soliq huquqi', 'Tadbirkorlik huquqi'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: GlobalAppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        title: GlobalText(
          text: 'Huquqiy ko\'rsatmalar',
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: GlobalTextField(
              hintText: 'Mavzu yoki kalit so\'z bo\'yicha qidirish',
              prefixIcon: const Icon(CupertinoIcons.search, color: AppColors.textHint, size: 20),
              textColor: isDark ? AppColors.white : AppColors.navyText,
              hintTextColor: AppColors.textHint,
              borderColor: isDark ? AppColors.darkBorder : AppColors.borderStrong,
              fillColor: Theme.of(context).cardColor,
              onChanged: (v) => context.read<ArticleBloc>().add(SearchArticlesChanged(v)),
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.search,
              validator: (_) => null,
            ),
          ),
          const SizedBox(height: 6),
          // Categories list horizontal
          SizedBox(
            height: 38,
            child: BlocBuilder<ArticleBloc, ArticleState>(
              buildWhen: (p, c) => p.selectedCategory != c.selectedCategory,
              builder: (context, state) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = state.selectedCategory == cat;
                    return GestureDetector(
                      onTap: () {
                        context.read<ArticleBloc>().add(CategoryFilterChanged(cat));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? (isDark ? AppColors.gold : AppColors.navy)
                              : (isDark ? Theme.of(context).cardColor : AppColors.chipBg),
                          borderRadius: BorderRadius.circular(20),
                          border: isDark ? Border.all(color: AppColors.darkBorder) : null,
                        ),
                        child: Center(
                          child: GlobalText(
                            text: cat,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected 
                                ? (isDark ? AppColors.navyText : AppColors.white)
                                : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          // Articles list
          Expanded(
            child: BlocBuilder<ArticleBloc, ArticleState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(child: AdolatLoader());
                }
                if (state.filteredArticles.isEmpty) {
                  return const Center(
                    child: GlobalText(
                      text: 'Hech qanday maqola topilmadi',
                      color: AppColors.textMuted,
                    ),
                  );
                }
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: state.filteredArticles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final article = state.filteredArticles[index];
                    return _ArticleCard(article: article);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppCard(
      onTap: () => context.push(AppRouteNames.articleDetail, extra: article),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GlobalText(
              text: article.category,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.gold : const Color(0xFF8C6F2D),
            ),
          ),
          const SizedBox(height: 10),
          GlobalText(
            text: article.title,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
            maxLines: 2,
            isEllipsis: true,
          ),
          const SizedBox(height: 6),
          GlobalText(
            text: article.content,
            fontSize: 12.5,
            color: AppColors.textMuted,
            maxLines: 2,
            isEllipsis: true,
            height: 1.45,
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GlobalText(
                text: 'O\'qish',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.gold : AppColors.navy,
              ),
              const SizedBox(width: 4),
              Icon(
                CupertinoIcons.arrow_right,
                size: 13,
                color: isDark ? AppColors.gold : AppColors.navy,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
