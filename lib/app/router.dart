import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/today_page.dart';
import '../features/dashboard/trends_page.dart';
import '../features/evidence/guide_page.dart';
import '../features/nutrition/meal_form.dart';
import '../features/symptoms/symptom_form.dart';
import '../features/weight/weight_form.dart';
import '../features/meal_plans/plan_page.dart';
import '../features/measurements/log_page.dart';
import '../features/recipes/recipe_detail_page.dart';
import '../features/recipes/recipes_page.dart';
import '../features/shopping/shopping_list_page.dart';
import '../features/measurements/measurement_session_form.dart';
import '../features/onboarding/onboarding_page.dart';
import 'app_shell.dart';

/// Uygulama yönlendiricisi (MASTER_PROMPT §5): 5 sekmeli ana kabuk +
/// onboarding akışı. Profil, ayarlar ve veri yönetimi sonraki görevlerde
/// üst menüye bağlanır.
final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/today',
              builder: (context, state) => const TodayPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/log',
              builder: (context, state) => const LogPage(),
              routes: [
                GoRoute(
                  path: 'session',
                  builder: (context, state) => Scaffold(
                    appBar: AppBar(),
                    body: const MeasurementSessionForm(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/plan',
              builder: (context, state) => const PlanPage(),
              routes: [
                GoRoute(
                  path: 'recipes',
                  builder: (context, state) => const RecipesPage(),
                  routes: [
                    GoRoute(
                      path: ':id',
                      builder: (context, state) => RecipeDetailPage(
                        recipeId: state.pathParameters['id']!,
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'shopping',
                  builder: (context, state) => const ShoppingListPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/trends',
              builder: (context, state) => const TrendsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/guide',
              builder: (context, state) => const GuidePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: '/meals/new', builder: (context, state) => const MealForm()),
    GoRoute(
      path: '/weight/new',
      builder: (context, state) => const WeightForm(),
    ),
    GoRoute(
      path: '/symptoms/new',
      builder: (context, state) => const SymptomForm(),
    ),
  ],
);
